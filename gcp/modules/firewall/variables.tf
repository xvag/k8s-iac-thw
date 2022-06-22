variable "fw_name" {
    description = "Firewall Name"
}

variable "vpc_name" {
    description = "VPC Name"
}

variable "vpc_subnet" {
    description = "VPC Subnet"
}

variable "rule" {
    description = "Firewall Rules"

    type        = map(object({
      protocol  = string
      ports     = list(string)
      ranges    = list(string)
    }))
}
