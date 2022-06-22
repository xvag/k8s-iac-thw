resource "google_compute_firewall" "firewall" {
  name     = var.fw_name
  network  = var.vpc_name

  dynamic "rule" {
    for_each = var.rule
    content {
      allow {
        protocol = var.rule.protocol
        ports    = var.rule.ports
      }
      source_ranges = var.rule.ranges
    }
  }

  depends_on = [
    var.vpc_subnet
  ]
}
