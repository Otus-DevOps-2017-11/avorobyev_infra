provider "google" {
  #version     = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "db" {
  source     = "../modules/db"
  disk_image = "${var.db_disk_image}"
  zone       = "${var.zone}"
  keys       = "${var.keys}"
  env_tag = "prod"
}

module "app" {
  source     = "../modules/app"
  disk_image = "${var.app_disk_image}"
  zone       = "${var.zone}"
  keys       = "${var.keys}"
  env_tag = "prod"
}

module "vpc" {
  source = "../modules/vpc"

  #source_ranges = ["${var.adm_ip_range}"]
}
