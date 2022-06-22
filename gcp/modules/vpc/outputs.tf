output "vpc_name" {
    value = google_compute_network.vpc.name
}

output "subnet_name" {
    value = google_compute_subnetwork.subnet.name
}

output "vpc_self_link" {
  value       = google_compute_network.vpc.self_link
  description = "The URI of the VPC being created"
}
