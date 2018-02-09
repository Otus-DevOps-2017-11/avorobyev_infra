variable zone {
  type        = "string"
  description = "GCP instance zone"
  default     = "europe-west1-d"
}

variable disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-db-base"
}

variable tags {
  type        = "list"
  description = "instance tags"
  default     = ["reddit-db"]
}

variable src_tags {
  type        = "list"
  description = "client instances' tags"
  default     = ["reddit-app"]
}

variable keys {
  description = "Paths to the keys used for ssh access"
  type        = "map"
  default     = {}
}
