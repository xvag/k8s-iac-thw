module "c-vpc" {
  source        = "./modules/vpc"
  vpc_name      = var.vpc.controller.name
  subnet_name   = "${var.vpc.controller.name}-subnet"
  subnet_region = var.vpc.controller.region
  subnet_cidr   = var.vpc.controller.cidr
  fw_name       = "${var.vpc.controller.name}-fw"
  fw_ports      = var.vpc.controller.fw_ports
}

module "w-vpc" {
  source        = "./modules/vpc"
  vpc_name      = var.vpc.worker.name
  subnet_name   = "${var.vpc.worker.name}-subnet"
  subnet_region = var.vpc.worker.region
  subnet_cidr   = var.vpc.worker.cidr
  fw_name       = "${var.vpc.worker.name}-fw"
  fw_ports      = var.vpc.worker.fw_ports
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
  vm_meta    = var.vm.controller.meta
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
  vm_meta    = var.vm.worker.meta
}
