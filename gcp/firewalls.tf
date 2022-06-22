
module "fw-in-cluster-c" {
  source     = "./modules/firewall"
  fw_name    = "fw-in-cluster-c"
  vpc_name   = module.c-vpc.vpc_name
  vpc_subnet = module.c-vpc.subnet_name
  rules      = var.fw_in_cluster
  src_ranges = ["${var.vpc.controller.cidr}","${var.vpc.worker.cidr}","${var.pod_cidr_range}"]
}

module "fw-in-cluster-w" {
  source     = "./modules/firewall"
  fw_name    = "fw-in-cluster-w"
  vpc_name   = module.w-vpc.vpc_name
  vpc_subnet = module.w-vpc.subnet_name
  rules      = var.fw_in_cluster
  src_ranges = ["${var.vpc.controller.cidr}","${var.vpc.worker.cidr}","${var.pod_cidr_range}"]
}

module "fw-allow-health-checks" {
  source     = "./modules/firewall"
  fw_name    = "fw-allow-health-checks"
  vpc_name   = module.c-vpc.vpc_name
  vpc_subnet = module.c-vpc.subnet_name
  rules      = var.fw_allow_health_checks
  src_ranges = ["209.85.152.0/22", "209.85.204.0/22", "35.191.0.0/16"]
}

module "fw-controller-vpc" {
  source     = "./modules/firewall"
  fw_name    = "fw-controller-vpc"
  vpc_name   = module.c-vpc.vpc_name
  vpc_subnet = module.c-vpc.subnet_name
  rules      = var.fw_controller_vpc
  src_ranges = ["0.0.0.0/0"]
}

module "fw-worker-vpc" {
  source     = "./modules/firewall"
  fw_name    = "fw-worker-vpc"
  vpc_name   = module.w-vpc.vpc_name
  vpc_subnet = module.w-vpc.subnet_name
  rules      = var.fw_worker_vpc
  src_ranges = ["0.0.0.0/0"]
}
