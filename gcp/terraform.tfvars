###
### Variable Definitions
###

###
### VM Variables
### The amount of IPs have to match the amount of instances (no)
###

vpc = {
  "controller" = {
    name     = "controller"
    region   = "europe-west4"
    cidr     = "10.240.0.0/24"
    fw_ports = ["22","6443"]
  },
  "worker" = {
    name     = "worker"
    region   = "us-central1"
    cidr     = "10.250.0.0/24"
    fw_ports = ["22"]
  }
}

vm = {
  "controller" = {
    name    = "controller"
    zone    = "europe-west4-a"
    machine = "e2-standard-2"
    image   = "ubuntu-os-cloud/ubuntu-2004-lts"
    size    = "200"
    ip      = ["10.240.0.10","10.240.0.11","10.240.0.12"]
    tags    = ["k8s", "controller"]
  },
  "worker" = {
    name    = "worker"
    zone    = "us-central1-c"
    machine = "e2-standard-2"
    image   = "ubuntu-os-cloud/ubuntu-2004-lts"
    size    = "200"
    ip      = ["10.250.0.20","10.250.0.21","10.250.0.22"]
    tags    = ["k8s", "worker"]
  }
}

###
### Target Pool of the Controllers for the Health Checks
###

target-pool     = [
                    "europe-west4-a/controller-0",
                    "europe-west4-a/controller-1",
                    "europe-west4-a/controller-2",
                  ]

###
### Kubernetes Variables
###

service-cluster-ip-range = "10.32.0.0/24"

### Apply one POD-CIDR for every Worker instance
pod-cidr-range = "10.200.0.0/16"
pod-cidr       = ["10.200.0.0/24","10.200.1.0/24","10.200.2.0/24"]
