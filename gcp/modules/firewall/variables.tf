variable "fw_name" {
    description = "Firewall Name"
}

variable "vpc_name" {
    description = "VPC Name"
}

variable "vpc_subnet" {
    description = "VPC Subnet"
}

variable "rules" {
    description = "Firewall Rules"

    type        = map(object({
      ports     = list(string)
    }))
}

variable "src_ranges" {
    description = "Source IP Ranges"
}
