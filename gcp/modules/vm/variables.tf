variable "vm_name" {
    description = "VM Name"
}

variable "vm_zone" {
    description = "VM Zone"
}

variable "vm_machine" {
    description = "VM Machine Type"
}

variable "vm_image" {
    description = "VM Image"
}

variable "vm_size" {
    description = "VM Disk Size"
}

variable "vm_ip" {
    description = "VM IP"
}

variable "vm_tags" {
    description = "VM Tags"
}

variable "vm_scopes" {
    description = "VM Service Account Scopes"
}

variable "vm_subnet" {
    description = "VM Subnet"
}

variable "pod_cidr" {
    description = "POD CIDR (optional metadata)"
    default     = null
}
