resource "google_compute_instance" "db" {

  name = "reddit-db-${var.env_tag}"

  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"

  tags = "${var.tags}"

  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  network_interface {

    network = "default"

    access_config = {}
  }

  metadata {
    sshKeys = "appuser:${file(var.keys["public"])}"
  }
}
