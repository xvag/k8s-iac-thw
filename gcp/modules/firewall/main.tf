resource "google_compute_firewall" "firewall" {
  name     = var.fw_name
  network  = var.vpc_name

  dynamic "setting" {
    for_each = var.rule
    content {
      allow {
        protocol = setting.value["protocol"]
        ports    = setting.value["ports"]
      }
      source_ranges = setting.value["ranges"]
    }
  }

  depends_on = [
    var.vpc_subnet
  ]
}
