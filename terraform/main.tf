provider "google" {
  #version     = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "${var.zone}"

  tags = ["reddit-app"]

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"

    # использовать ephemeral IP для доступа из Интернет
    access_config {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  ##ключи
  #metadata {
  #  sshKeys = "appuser:${file(var.keys["public"])}"
  #}

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.keys["private"])}"
  }
  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_project_metadata_item" "project_keys" {
  key = "ssh-keys"

  value = <<EOF
appuser:${ trimspace( file(var.keys["public"]) ) }
appuser1:${ trimspace( file(var.keys["public"]) ) }
appuser2:${ trimspace( file(var.keys["public"]) ) }
EOF
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
  #address_type = "INTERNAL"
}
