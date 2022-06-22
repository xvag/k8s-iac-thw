module "k8s-ip" {
  source       = "./modules/address"
  address_name = "k8s-ip"
  vpc_region   = var.vpc.controller.region
}

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

module "c-fw-in" {
  source     = "./modules/firewall"
  fw_name    = "c-fw-in"
  vpc_name   = module.c-vpc.vpc_name
  vpc_subnet = module.c-vpc.subnet_name
  rules      = var.fw_in
  src_ranges = ["${var.vpc.controller.cidr}","${var.vpc.worker.cidr}","${var.pod_cidr_range}"]
}

module "w-fw-in" {
  source     = "./modules/firewall"
  fw_name    = "w-fw-in"
  vpc_name   = module.w-vpc.vpc_name
  vpc_subnet = module.w-vpc.subnet_name
  rules      = var.fw_in
  src_ranges = ["${var.vpc.controller.cidr}","${var.vpc.worker.cidr}","${var.pod_cidr_range}"]
}

module "c-fw-ex" {
  source     = "./modules/firewall"
  fw_name    = "c-fw-ex"
  vpc_name   = module.c-vpc.vpc_name
  vpc_subnet = module.c-vpc.subnet_name
  rules      = var.fw_ex_c
  src_ranges = ["0.0.0.0/0"]
}

module "w-fw-ex" {
  source     = "./modules/firewall"
  fw_name    = "w-fw-ex"
  vpc_name   = module.w-vpc.vpc_name
  vpc_subnet = module.w-vpc.subnet_name
  rules      = var.fw_ex_w
  src_ranges = ["0.0.0.0/0"]
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

module "c-vm" {
  count = 3

  source     = "./modules/vm"
  vm_name    = "${var.vm.controller.name}-${count.index}"
  vm_zone    = var.vm.controller.zone
  vm_machine = var.vm.controller.machine
  vm_image   = var.vm.controller.image
  vm_size    = var.vm.controller.size
  vm_ip      = var.vm.controller.ip[count.index]
  vm_tags    = var.vm.controller.tags
  vm_scopes  = var.vm.controller.scopes
  vm_subnet  = module.c-vpc.subnet_name
}

module "w-vm" {
  count = 3

  source     = "./modules/vm"
  vm_name    = "${var.vm.worker.name}-${count.index}"
  vm_zone    = var.vm.worker.zone
  vm_machine = var.vm.worker.machine
  vm_image   = var.vm.worker.image
  vm_size    = var.vm.worker.size
  vm_ip      = var.vm.worker.ip[count.index]
  vm_tags    = var.vm.worker.tags
  vm_scopes  = var.vm.worker.scopes
  vm_subnet  = module.w-vpc.subnet_name
  pod_cidr   = var.pod_cidr[count.index]
}
