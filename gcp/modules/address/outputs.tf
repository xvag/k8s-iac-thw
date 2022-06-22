output "public_ip_address" {
  value       = google_compute_address.public_ip.address
}

output "address_name" {
  value       = google_compute_address.public_ip.name
}
