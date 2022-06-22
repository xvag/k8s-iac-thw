# Worker Resources

resource "google_compute_network" "worker-vpc" {
  name = "worker-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "worker-subnet" {
  name          = "worker-subnet"
  region        = var.vpc.worker.region
  ip_cidr_range = var.vpc.worker.subnet
  network       = google_compute_network.worker-vpc.id
}

resource "google_compute_firewall" "worker-fw" {
  name     = "worker-fw"
  network  = "worker-vpc"
  allow {
    protocol = "tcp"
    ports    = var.vpc.worker.fw
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
  depends_on = [
    google_compute_subnetwork.worker-subnet
  ]
}

resource "google_compute_instance" "worker" {
  count = var.vpc.worker.no

  name                      = "${var.vpc.worker.name}-${count.index}"
  machine_type              = var.vpc.worker.machine
  zone                      = var.vpc.worker.zone
  allow_stopping_for_update = true
  can_ip_forward            = true
  tags                      = ["k8s", "worker"]
  boot_disk {
    initialize_params {
      image = var.vpc.worker.image
      size  = var.vpc.worker.size
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.worker-subnet.self_link
    network_ip = var.vpc.worker.ip[count.index]
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
    google_compute_subnetwork.worker-subnet
  ]
}
