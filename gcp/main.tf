
###
### Create VPC, Subnet, Firewall Rules and Public-IP
###

resource "google_compute_address" "k8s-ip" {
  name   = "k8s-ip"
  region = var.region
}

resource "google_compute_network" "k8s-vpc" {
  name = "k8s-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "k8s-subnet" {
  name          = "k8s-subnet"
  region        = var.region
  ip_cidr_range = var.subnet
  network       = google_compute_network.k8s-vpc.id
}

resource "google_compute_firewall" "k8s-fw-in" {
  name     = "k8s-fw-in"
  network  = "k8s-vpc"
  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["${var.subnet}","${var.pod-cidr-range}","${var.service-cluster-ip-range}"]
  depends_on = [
    google_compute_subnetwork.k8s-subnet
  ]
}

resource "google_compute_firewall" "k8s-fw-ex" {
  name     = "k8s-fw-ex"
  network  = "k8s-vpc"
  allow {
    protocol = "tcp"
    ports    = var.fw-ex-ports
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
  depends_on = [
    google_compute_subnetwork.k8s-subnet
  ]
}

resource "google_compute_firewall" "k8s-fw-allow-health-check" {
  name    = "k8s-fw-allow-health-check"
  network = "k8s-vpc"
  allow {
    protocol = "tcp"
  }
  source_ranges  = ["209.85.152.0/22", "209.85.204.0/22", "35.191.0.0/16"]
  depends_on = [
    google_compute_subnetwork.k8s-subnet
  ]
}

###
### Create Forwarding from Public-IP, Controllers' Health-Check and Cluster's pods Routing
###

resource "google_compute_http_health_check" "k8s-health-check" {
  name         = "k8s-health-check"
  host         = "kubernetes.default.svc.cluster.local"
  request_path = "/healthz"
}

resource "google_compute_target_pool" "k8s-target-pool" {
  name = "k8s-target-pool"
  instances = var.target-pool
  health_checks = [
    google_compute_http_health_check.k8s-health-check.name,
  ]
}

resource "google_compute_forwarding_rule" "k8s-forwarding-rule" {
  name       = "k8s-forwarding-rule"
  ip_address = google_compute_address.k8s-ip.address
  port_range = "6443-6443"
  region     = var.region
  target     = google_compute_target_pool.k8s-target-pool.id
  depends_on = [
    google_compute_address.k8s-ip,
    google_compute_target_pool.k8s-target-pool
  ]
}

resource "google_compute_route" "k8s-pods-route" {
  count       = var.worker-no

  name        = "k8s-route-pods-worker-${count.index}"
  dest_range  = var.pod-cidr[count.index]
  network     = "k8s-vpc"
  next_hop_ip = var.worker-ip[count.index]
  depends_on = [
    google_compute_subnetwork.k8s-subnet
  ]
}

###
### Create the VMs
###

resource "google_compute_instance" "controller" {
  count = var.controller-no

  name                      = var.controller-name[count.index]
  machine_type              = var.machine
  zone                      = var.zone
  allow_stopping_for_update = true
  can_ip_forward            = true
  tags                      = ["k8s", "controller"]
  boot_disk {
    initialize_params {
      image = var.image
      size  = var.size
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.k8s-subnet.self_link
    network_ip = var.controller-ip[count.index]
    access_config {
    }
  }
  service_account {
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_key}"
  }
  depends_on = [
    google_compute_subnetwork.k8s-subnet
  ]
}

resource "google_compute_instance" "worker" {
  count = var.worker-no

  name                      = var.worker-name[count.index]
  machine_type              = var.machine
  zone                      = var.zone
  allow_stopping_for_update = true
  can_ip_forward            = true
  tags                      = ["k8s", "worker"]
  boot_disk {
    initialize_params {
      image = var.image
      size  = var.size
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.k8s-subnet.self_link
    network_ip = var.worker-ip[count.index]
    access_config {
    }
  }
  service_account{
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_key}"
    pod-cidr = var.pod-cidr[count.index]
  }
  depends_on = [
    google_compute_subnetwork.k8s-subnet
  ]
}
