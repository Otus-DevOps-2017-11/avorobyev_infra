provider "google" {
  #version     = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module nodes {

  source = "../modules/nodes"
  zone       = "${var.zone}"
  keys       = "${var.keys}"
  instances = [
    {
      name = "reddit-app-stage",
      disk_image = "reddit-app-base",
      machine_type = "f1-micro",
      tags = "app-stage"
    },
    {
      name = "reddit-db-stage",
      disk_image = "reddit-db-base",
      machine_type = "f1-micro",
      tags = "db-stage"
    }
  ]
}

module "vpc" {

  source = "../modules/vpc"
  env_tag = "stage"

  access_table_external = [
    {
        tags_to = "app-stage,db-stage",
        ports = "22"
    },
    {
        tags_to = "app-stage",
        ports = "80,443,9292"
    }
  ]

  access_table = [
    {
        tags_from = "app-stage",
        tags_to = "db-stage",
        ports = "27017"
    }
  ]
}
