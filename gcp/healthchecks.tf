### Public IP, Load Balancer and Health-Check
### of the Controllers of the Cluster.

module "k8s-ip" {
  source       = "./modules/address"
  address_name = "k8s-ip"
  vpc_region   = var.vpc.controller.region
}

resource "google_compute_http_health_check" "k8s-health-check" {
  name         = "k8s-health-check"
  host         = "kubernetes.default.svc.cluster.local"
  request_path = "/healthz"
}

resource "google_compute_target_pool" "k8s-target-pool" {
  name      = "k8s-target-pool"
  instances = var.target_pool
  region    = var.vpc.controller.region
  health_checks = [
    google_compute_http_health_check.k8s-health-check.name,
  ]
}

resource "google_compute_forwarding_rule" "k8s-forwarding-rule" {
  name       = "k8s-forwarding-rule"
  ip_address = module.k8s-ip.public_ip_address
  port_range = "6443-6443"
  region     = var.vpc.controller.region
  target     = google_compute_target_pool.k8s-target-pool.id
  depends_on = [
    module.k8s-ip.address_name,
    google_compute_target_pool.k8s-target-pool
  ]
}
