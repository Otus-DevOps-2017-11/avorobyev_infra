resource "google_compute_instance" "gcp_instance" {

  count = "${length(var.instances)}"

  name         = "${ lookup(var.instances[count.index], "name") }"

  machine_type = "${ lookup(var.instances[count.index], "machine_type") }"

  zone         = "${var.zone}"

  tags = "${ split(",", lookup(var.instances[count.index], "tags")) }"

  boot_disk {
    initialize_params {
      image = "${ lookup(var.instances[count.index], "disk_image") }"
    }
  }

  network_interface {

    network = "default"

    access_config = {
      #nat_ip = "${google_compute_address.app_ip.address}" #only one allowed for free
    }
  }

  metadata {
    sshKeys = "appuser:${file(var.keys["public"])}"
  }
}

#resource "google_compute_address" "app_ip" {
#  name = "reddit-app-ip-${var.env_tag}"
#}
