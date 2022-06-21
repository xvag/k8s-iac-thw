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
  type      = string
  sensitive = true
}

variable "ssh_key" {
  type      = string
  sensitive = true
}

variable "vpc" {
  type      = map(object({
    no      = number
    name    = string
    region  = string
    zone    = string
    machine = string
    image   = string
    size    = string
    subnet  = string
    ip      = list(string)
    fw      = list(string)
  }))
}


variable "target-pool" {
  type = list(string)
}

variable "pod-cidr-range" {
  type = string
}

variable "pod-cidr" {
  type = list(string)
}

variable "service-cluster-ip-range" {
  type = string
}
