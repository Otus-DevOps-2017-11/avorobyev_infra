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
  env_tag = "stage"
}

module "app" {
  source     = "../modules/app"
  disk_image = "${var.app_disk_image}"
  zone       = "${var.zone}"
  keys       = "${var.keys}"
  env_tag = "stage"
}

#module "vpc" {
#  source = "../modules/vpc"
#  #source_ranges = ["${var.adm_ip_range}"]
#}

module "vpcc" {

  source = "../modules/vpcc"

  access_table_from_all = [
    {
        tags_to = "reddit-app,reddit-db",
        ports = "22"
    },
    {
        tags_to = "reddit-app",
        ports = "80,443,9292"
    }
  ]

  access_table = [
    {
        tags_from = "reddit-app",
        tags_to = "reddit-db",
        ports = "27017"
    }
  ]
}
