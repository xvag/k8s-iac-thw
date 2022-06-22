resource "google_compute_address" "address" {
  name   = var.address_name
  region = var.vpc_region
}
