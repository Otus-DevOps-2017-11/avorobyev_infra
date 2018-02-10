variable zone {
  type        = "string"
  description = "GCP instance zone"
  default     = "europe-west1-d"
}

variable disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable tags {
  type        = "list"
  description = "instance tags"
  default     = ["reddit-app"]
}

variable keys {
  description = "Paths to the keys used for ssh access"
  type        = "map"
  default     = {}
}
