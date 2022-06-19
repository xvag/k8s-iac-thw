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

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "subnet" {
  type = string
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

variable "fw-ex-ports" {
  type = list(string)
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
