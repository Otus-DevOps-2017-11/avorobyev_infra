resource "google_compute_instance" "app" {
  name         = "reddit-app-${var.env_tag}"
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

    access_config = {
      #nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  metadata {
    sshKeys = "appuser:${file(var.keys["public"])}"
  }
}

#resource "google_compute_address" "app_ip" {
#  name = "reddit-app-ip-${var.env_tag}"
#}

#resource "google_compute_firewall" "firewall_puma" {
#  name    = "allow-puma-default-${var.env_tag}"
#  network = "default"
#
#  allow {
#    protocol = "tcp"
#    ports    = ["9292"]
#  }
#
#  source_ranges = ["0.0.0.0/0"]
#  target_tags   = "${var.tags}"
#}
