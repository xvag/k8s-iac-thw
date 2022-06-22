resource "google_compute_firewall" "firewall" {
  name     = var.fw_name
  network  = var.vpc_name

  dynamic "allow" {
    for_each = var.rules
    content {
        protocol = allow.key
        ports    = allow.value.ports
    }
  }
  source_ranges = var.src_ranges

  depends_on = [
    var.vpc_subnet
  ]
}
