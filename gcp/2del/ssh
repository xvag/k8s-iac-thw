resource "google_compute_project_metadata_item" "ssh-keys" {
  project = var.gcp_project
  key     = "ssh-keys"
  value   = "${var.ssh_user}:${var.ssh_key}"
}
