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
      name = "reddit-app-prod",
      disk_image = "reddit-app-base",
      machine_type = "g1-small",
      tags = "app-prod"
    },
    {
      name = "reddit-db-prod",
      disk_image = "reddit-db-base",
      machine_type = "g1-small",
      tags = "db-prod"
    }
  ]
}

module "vpc" {

  source = "../modules/vpc"
  env_tag = "prod"

  access_table_external = [
    {
        tags_to = "app-prod,db-prod",
        ports = "22"
    },
    {
        tags_to = "app-prod",
        ports = "80,443,9292"
    }
  ]

  access_table = [
    {
        tags_from = "app-prod",
        tags_to = "db-prod",
        ports = "27017"
    }
  ]
}
