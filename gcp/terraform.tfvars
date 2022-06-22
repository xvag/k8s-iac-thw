###
### Variable Definitions
###

###
### VM Variables
### The amount of IPs have to match the amount of instances (no)
###

vpc = {
  "controller" = {
    no      = 3
    name    = "controller"
    region  = "europe-west4"
    zone    = "europe-west4-a"
    machine = "e2-standard-2"
    image   = "ubuntu-os-cloud/ubuntu-2004-lts"
    size    = "200"
    subnet  = "10.240.0.0/24"
    ip      = ["10.240.0.10","10.240.0.11","10.240.0.12"]
    fw      = ["22","6443"]
  },
  "worker" = {
    no      = 3
    name    = "worker"
    region  = "us-central1"
    zone    = "us-central1-c"
    machine = "e2-standard-2"
    image   = "ubuntu-os-cloud/ubuntu-2004-lts"
    size    = "200"
    subnet  = "10.250.0.0/24"
    ip      = ["10.250.0.20","10.250.0.21","10.250.0.22"]
    fw      = ["22"]
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
