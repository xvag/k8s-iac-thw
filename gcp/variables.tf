###
### Variable Declarations
###

variable "gcp_project" {
  type      = string
  sensitive = true
  description = "Google Cloud project ID"
}

variable "gcp_creds" {
  type        = string
  sensitive   = true
  description = "Google Cloud service account credentials"
}

variable "ssh_user" {
  type        = string
  sensitive   = true
  description = "SSH username for connecting to VMs"
}

variable "ssh_key" {
  type        = string
  sensitive   = true
  description = "SSH .pub key for connecting to VMs"
}

variable "vpc" {
  type       = map(object({
    name     = string
    region   = string
    cidr     = string
  }))
}

variable "vm" {
  type      = map(object({
    name    = string
    zone    = string
    machine = string
    image   = string
    size    = string
    ip      = list(string)
    tags    = list(string)
    scopes  = list(string)
  }))
}

variable "fw" {
    type        = map(map(object({
      ports     = list(string)
    })))
}

variable "pod_cidr" {
  type = list(string)
}

variable "pod_cidr_range" {
  type = string
}

variable "target_pool" {
  type = list(string)
}

variable "service-cluster-ip-range" {
  type = string
}
