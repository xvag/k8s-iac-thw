### Inside Cluster Network Firewall Rule

resource "google_compute_firewall" "controller-fw-in" {
  name     = "controller-fw-in"
  network  = "controller-vpc"
  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["${var.vpc.controller.subnet}","${var.vpc.worker.subnet}","${var.pod-cidr-range}"]
  depends_on = [
    google_compute_subnetwork.controller-subnet
  ]
}

resource "google_compute_firewall" "worker-fw-in" {
  name     = "worker-fw-in"
  network  = "worker-vpc"
  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["${var.vpc.controller.subnet}","${var.vpc.worker.subnet}","${var.pod-cidr-range}"]
  depends_on = [
    google_compute_subnetwork.worker-subnet
  ]
}
