resource "google_compute_firewall" "firewall" {
  name     = var.fw_name
  network  = var.vpc_name

  dynamic "allow" {
    for_each = var.rule
    content {
        protocol = allow.value.protocol
        ports    = allow.value.ports
    }
  }
  source_ranges = [allow.value.ranges]

  depends_on = [
    var.vpc_subnet
  ]
}
