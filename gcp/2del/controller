### Controller Resources

resource "google_compute_network" "controller-vpc" {
  name = "controller-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "controller-subnet" {
  name          = "controller-subnet"
  region        = var.vpc.controller.region
  ip_cidr_range = var.vpc.controller.subnet
  network       = google_compute_network.controller-vpc.id
}

resource "google_compute_firewall" "controller-fw" {
  name     = "controller-fw"
  network  = "controller-vpc"
  allow {
    protocol = "tcp"
    ports    = var.vpc.controller.fw
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
  depends_on = [
    google_compute_subnetwork.controller-subnet
  ]
}

resource "google_compute_instance" "controller" {
  count = var.vpc.controller.no

  name                      = "${var.vpc.controller.name}-${count.index}"
  machine_type              = var.vpc.controller.machine
  zone                      = var.vpc.controller.zone
  allow_stopping_for_update = true
  can_ip_forward            = true
  tags                      = ["k8s", "controller"]
  boot_disk {
    initialize_params {
      image = var.vpc.controller.image
      size  = var.vpc.controller.size
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.controller-subnet.self_link
    network_ip = var.vpc.controller.ip[count.index]
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
    google_compute_subnetwork.controller-subnet
  ]
}
