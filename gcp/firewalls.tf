
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
