resource "google_compute_firewall" "firewall" {
  name     = var.fw_name
  network  = var.vpc_name

  dynamic "origin" {
    for_each = var.rule
    content {
      allow {
        protocol = origin.value.protocol
        ports    = origin.value.ports
      }
      source_ranges = origin.value.ranges
    }
  }

  depends_on = [
    var.vpc_subnet
  ]
}
