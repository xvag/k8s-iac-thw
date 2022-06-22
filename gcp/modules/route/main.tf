resource "google_compute_route" "route" {
  name        = var.route_name
  dest_range  = var.route_dest
  next_hop_ip = var.route_hopip
  network     = var.vpc_name
  depends_on = [
    var.subnet_name,
    var.peer_cw,
    var.peer_wc
  ]
}
