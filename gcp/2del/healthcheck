### Public IP, Load Balancer and Health-Check
### of the Controllers of the Cluster.

resource "google_compute_address" "k8s-ip" {
  name   = "k8s-ip"
  region = var.vpc.controller.region
}

resource "google_compute_firewall" "k8s-fw-allow-health-check" {
  name    = "k8s-fw-allow-health-check"
  network = "controller-vpc"
  allow {
    protocol = "tcp"
  }
  source_ranges  = ["209.85.152.0/22", "209.85.204.0/22", "35.191.0.0/16"]
  depends_on = [
    google_compute_subnetwork.controller-subnet
  ]
}

resource "google_compute_http_health_check" "k8s-health-check" {
  name         = "k8s-health-check"
  host         = "kubernetes.default.svc.cluster.local"
  request_path = "/healthz"
}

resource "google_compute_target_pool" "k8s-target-pool" {
  name      = "k8s-target-pool"
  instances = var.target-pool
  region    = var.vpc.controller.region
  health_checks = [
    google_compute_http_health_check.k8s-health-check.name,
  ]
}

resource "google_compute_forwarding_rule" "k8s-forwarding-rule" {
  name       = "k8s-forwarding-rule"
  ip_address = google_compute_address.k8s-ip.address
  port_range = "6443-6443"
  region     = var.vpc.controller.region
  target     = google_compute_target_pool.k8s-target-pool.id
  depends_on = [
    google_compute_address.k8s-ip,
    google_compute_target_pool.k8s-target-pool
  ]
}
