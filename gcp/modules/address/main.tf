resource "google_compute_address" "public_ip" {
  name   = var.address_name
  region = var.vpc_region
}
