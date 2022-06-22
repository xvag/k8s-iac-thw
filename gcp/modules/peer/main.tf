resource "google_compute_network_peering" "vpc-peer" {
  name         = var.peer_name
  network      = var.net
  peer_network = var.net_peer
}
