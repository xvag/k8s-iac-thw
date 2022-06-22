terraform {
	required_providers {
		google = {
	    version = "~> 3.5.0"
		}
  }
}

provider "google" {
  project     = var.gcp_project
  credentials = var.gcp_creds
}

resource "google_compute_project_metadata_item" "ssh-keys" {
  project = var.gcp_project
  key     = "ssh-keys"
  value   = "${var.ssh_user}:${var.ssh_key}"
}
