output "vpc_name" {
    value = google_compute_network.vpc.name
}

output "subnet_name" {
    value = google_compute_subnetwork.subnet.name
}

output "network_self_link" {
  value       = module.vpc.network_self_link
  description = "The URI of the VPC being created"
}
