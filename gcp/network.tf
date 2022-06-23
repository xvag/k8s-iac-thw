###
### VPC/Subnets
###

module "c-vpc" {
  source        = "./modules/vpc"
  vpc_name      = "${var.vpc.controller.name}-vpc"
  subnet_name   = "${var.vpc.controller.name}-subnet"
  subnet_region = var.vpc.controller.region
  subnet_cidr   = var.vpc.controller.cidr
}

module "w-vpc" {
  source        = "./modules/vpc"
  vpc_name      = "${var.vpc.worker.name}-vpc"
  subnet_name   = "${var.vpc.worker.name}-subnet"
  subnet_region = var.vpc.worker.region
  subnet_cidr   = var.vpc.worker.cidr
}

###
### VPC Peerings
###

module "c-peer" {
  source    = "./modules/peer"
  peer_name = "c-w"
  net       = module.c-vpc.vpc_self_link
  net_peer  = module.w-vpc.vpc_self_link
}

module "w-peer" {
  source    = "./modules/peer"
  peer_name = "w-c"
  net       = module.w-vpc.vpc_self_link
  net_peer  = module.c-vpc.vpc_self_link
}

###
### Firewalls
###

module "fw-in-cluster-c" {
  source     = "./modules/firewall"
  fw_name    = "fw-in-cluster-c"
  vpc_name   = module.c-vpc.vpc_name
  vpc_subnet = module.c-vpc.subnet_name
  rules      = var.fw.in_cluster
  src_ranges = ["${var.vpc.controller.cidr}","${var.vpc.worker.cidr}","${var.pod_cidr_range}"]
}

module "fw-in-cluster-w" {
  source     = "./modules/firewall"
  fw_name    = "fw-in-cluster-w"
  vpc_name   = module.w-vpc.vpc_name
  vpc_subnet = module.w-vpc.subnet_name
  rules      = var.fw.in_cluster
  src_ranges = ["${var.vpc.controller.cidr}","${var.vpc.worker.cidr}","${var.pod_cidr_range}"]
}

module "fw-allow-health-checks" {
  source     = "./modules/firewall"
  fw_name    = "fw-allow-health-checks"
  vpc_name   = module.c-vpc.vpc_name
  vpc_subnet = module.c-vpc.subnet_name
  rules      = var.fw.allow_health_checks
  src_ranges = ["209.85.152.0/22", "209.85.204.0/22", "35.191.0.0/16"]
}

module "fw-controller-vpc" {
  source     = "./modules/firewall"
  fw_name    = "fw-controller-vpc"
  vpc_name   = module.c-vpc.vpc_name
  vpc_subnet = module.c-vpc.subnet_name
  rules      = var.fw.controller_vpc
  src_ranges = ["0.0.0.0/0"]
}

module "fw-worker-vpc" {
  source     = "./modules/firewall"
  fw_name    = "fw-worker-vpc"
  vpc_name   = module.w-vpc.vpc_name
  vpc_subnet = module.w-vpc.subnet_name
  rules      = var.fw.worker_vpc
  src_ranges = ["0.0.0.0/0"]
}

###
### Routes
###

module "k8s-pods-route" {
  count = 3

  source      = "./modules/route"
  route_name  = "k8s-route-pods-worker-${count.index}"
  route_dest  = var.pod_cidr[count.index]
  route_hopip = var.vm.worker.ip[count.index]
  vpc_name    = module.w-vpc.vpc_name
  subnet_name = module.w-vpc.subnet_name
  peer_cw     = module.c-peer.peer_name
  peer_wc     = module.w-peer.peer_name
}
