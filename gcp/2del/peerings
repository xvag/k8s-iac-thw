### VPC Peerings

resource "google_compute_network_peering" "controller-worker" {
  name         = "controller-worker"
  network      = google_compute_network.controller-vpc.self_link
  peer_network = google_compute_network.worker-vpc.self_link
}

resource "google_compute_network_peering" "worker-controller" {
  name         = "worker-controller"
  network      = google_compute_network.worker-vpc.self_link
  peer_network = google_compute_network.controller-vpc.self_link
}
