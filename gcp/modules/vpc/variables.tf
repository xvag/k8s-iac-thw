variable "vpc_name" {
    description = "VPC Name"
}

variable "subnet_name" {
    description = "Subnet Name"
}

variable "subnet_region" {
    description = "Subnet Region"
}

variable "subnet_cidr" {
    description = "Subnet CIDR"
}

variable "fw_name" {
    description = "Firewall Name"
}

variable "fw_ports" {
    description = "Firewall TCP Ports to Allow"
}
