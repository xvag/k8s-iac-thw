### Route rules for the POD network

resource "google_compute_route" "k8s-pods-route" {
  count       = var.vpc.worker.no

  name        = "k8s-route-pods-worker-${count.index}"
  dest_range  = var.pod-cidr[count.index]
  network     = "worker-vpc"
  next_hop_ip = var.vpc.worker.ip[count.index]
  depends_on = [
    google_compute_subnetwork.worker-subnet,
    google_compute_network_peering.controller-worker,
    google_compute_network_peering.worker-controller
  ]
}
