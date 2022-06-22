
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
