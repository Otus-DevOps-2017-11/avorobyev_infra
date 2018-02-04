
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
  type = "list"
  description = "instance tags"
  default = ["reddit-app"]
}
