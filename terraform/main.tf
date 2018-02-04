provider "google" {
  #version     = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "db" {
  source = "modules/db"
  disk_image = "${var.db_disk_image}"
  zone = "${var.zone}"
}

module "app" {
  source = "modules/app"
  disk_image = "${var.app_disk_image}"
  zone = "${var.zone}"
}

module "vpc" {
  source = "modules/vpc"
  #source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_project_metadata_item" "project_keys" {
  key   = "ssh-keys"
  value = "appuser:${ trimspace( file(var.keys["public"]) ) }"
}
