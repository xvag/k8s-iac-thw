
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
    subnetwork = google_compute_subnetwork.worker-subnet.self_link
    network_ip = var.vm_ip
    access_config {
    }
  }
  service_account{
    scopes = ["compute-rw","storage-ro","service-management","service-control","logging-write","monitoring"]
  }
  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_key}"
    pod-cidr = var.pod-cidr[count.index]
  }
  depends_on = [
    google_compute_subnetwork.worker-subnet
  ]
}
