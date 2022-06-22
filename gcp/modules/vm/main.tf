
resource "google_compute_instance" "vm" {
  name                      = var.vm_name
  zone                      = var.vm_zone
  machine_type              = var.vm_machine
  allow_stopping_for_update = true
  can_ip_forward            = true
  tags                      = var.vm_tags
  boot_disk {
    initialize_params {
      image = var.vm_image
      size  = var.vm_size
    }
  }
  network_interface {
    subnetwork = var.vm_subnet
    network_ip = var.vm_ip
    access_config {
    }
  }
  service_account{
    scopes = var.vm_scopes
  }

  metadata = {
    pod-cidr = var.pod_cidr
  }

  depends_on = [
    var.vm_subnet
  ]
}
