###
### VPC/Subnets
###

vpc = {
  "controller" = {
    name     = "controller"
    region   = "europe-west4"
    cidr     = "10.240.0.0/24"
  },
  "worker" = {
    name     = "worker"
    region   = "us-central1"
    cidr     = "10.250.0.0/24"
  }
}

###
### Firewalls
###

fw = {
  in_cluster = {
    "tcp" = {
      ports    = []
    }
    "udp" = {
      ports    = []
    }
    "icmp" = {
      ports    = []
    }
  },
  controller_vpc = {
    "tcp" = {
      ports    = ["22","6443"]
    }
    "icmp" = {
      ports    = []
    }
  },
  worker_vpc = {
    "tcp" = {
      ports    = ["22"]
    }
    "icmp" = {
      ports    = []
    }
  },
  allow_health_checks = {
    "tcp" = {
      ports    = []
    }
  }
}

###
### VMs
###

vm = {
  "controller" = {
    name    = "controller"
    zone    = "europe-west4-a"
    machine = "e2-standard-2"
    image   = "ubuntu-os-cloud/ubuntu-2004-lts"
    size    = "200"
    ip      = ["10.240.0.10","10.240.0.11","10.240.0.12"]
    tags    = ["k8s", "controller"]
    scopes  = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  },
  "worker" = {
    name    = "worker"
    zone    = "us-central1-c"
    machine = "e2-standard-2"
    image   = "ubuntu-os-cloud/ubuntu-2004-lts"
    size    = "200"
    ip      = ["10.250.0.20","10.250.0.21","10.250.0.22"]
    tags    = ["k8s", "worker"]
    scopes  = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
}

###
### Target Pool of the Controllers for the Health Checks
###

target_pool     = [
                    "europe-west4-a/controller-0",
                    "europe-west4-a/controller-1",
                    "europe-west4-a/controller-2",
                  ]

###
### Kubernetes Variables
###

service-cluster-ip-range = "10.32.0.0/24"

### Apply one POD-CIDR for every Worker instance
pod_cidr_range = "10.200.0.0/16"
pod_cidr       = ["10.200.0.0/24","10.200.1.0/24","10.200.2.0/24"]
