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

variable "controller-region" {
  type = string
}

variable "controller-zone" {
  type = string
}

variable "controller-subnet" {
  type = string
}

variable "controller-fw-ex-ports" {
  type = list(string)
}

variable "worker-region" {
  type = string
}

variable "worker-zone" {
  type = string
}

variable "worker-subnet" {
  type = string
}

variable "worker-fw-ex-ports" {
  type = list(string)
}

variable "machine" {
  type = string
}

variable "image" {
  type = string
}

variable "size" {
  type = string
}


variable "controller-no" {
  type = number
}

variable "controller-name" {
  type = list(string)
}

variable "controller-ip" {
  type = list(string)
}

variable "target-pool" {
  type = list(string)
}

variable "worker-no" {
  type = number
}

variable "worker-name" {
  type = list(string)
}

variable "worker-ip" {
  type = list(string)
}

variable "pod-cidr" {
  type = list(string)
}

variable "pod-cidr-range" {
  type = string
}

variable "service-cluster-ip-range" {
  type = string
}
