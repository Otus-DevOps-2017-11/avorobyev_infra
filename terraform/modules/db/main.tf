resource "google_compute_instance" "db" {
  name = "reddit-db"

  machine_type = "g1-small"
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

resource "google_compute_firewall" "firewall_mongo" {
  name = "allow-mongo-default"

  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }

  # правило применимо к инстансам с тегом ...
  target_tags = "${var.tags}"

  # порт будет доступен только для инстансов с тегом ...
  source_tags = "${var.src_tags}"
}
