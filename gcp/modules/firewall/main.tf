resource "google_compute_firewall" "firewall" {
  name     = var.fw_name
  network  = var.vpc_name
  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = var.src_ranges
  depends_on = [
    var.vpc_subnet
  ]
}
