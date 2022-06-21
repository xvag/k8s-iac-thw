###
### Common variables
###

machine = "e2-standard-2"
image   = "ubuntu-os-cloud/ubuntu-2004-lts"
size    = "200"

###
### Controller variables
###

controller-region  = "europe-west4"
controller-zone    = "europe-west4-a"
controller-subnet  = "10.240.0.0/24"
controller-fw-ex-ports   = ["22","6443"]


controller-no   = 3                                              # Number of Controllers
controller-name = ["controller-0","controller-1","controller-2"] # Names
controller-ip   = ["10.240.0.10","10.240.0.11","10.240.0.12"]    # Internal IP

target-pool     = [
                    "europe-west4-a/controller-0",
                    "europe-west4-a/controller-1",
                    "europe-west4-a/controller-2",
                  ]

###
### Worker variables
###

worker-region  = "us-central1"
worker-zone    = "us-central1-c"
worker-subnet  = "10.250.0.0/24"
worker-fw-ex-ports   = ["22"]

worker-no      = 3                                                 # Number of Workers
worker-name    = ["worker-0","worker-1","worker-2"]                # Names
worker-ip      = ["10.250.0.20","10.250.0.21","10.250.0.22"]       # Internal IP
pod-cidr       = ["10.200.0.0/24","10.200.1.0/24","10.200.2.0/24"] # Pod Subnet

pod-cidr-range = "10.200.0.0/16" # Pod Subnet range

service-cluster-ip-range = "10.32.0.0/24"
