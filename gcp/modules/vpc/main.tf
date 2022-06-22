resource "google_compute_network" "vpc" {
  name = var.vpc_name
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  region        = var.subnet_region
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.vpc.id
}

resource "google_compute_firewall" "fw" {
  name     = var.fw_name
  network  = var.vpc_name
  allow {
    protocol = "tcp"
    ports    = var.fw_ports
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
  depends_on = [
    google_compute_subnetwork.subnet
  ]
}
