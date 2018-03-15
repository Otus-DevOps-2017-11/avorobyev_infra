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

variable keys {
  description = "Paths to the keys used for ssh access"
  type        = "map"
  default     = {}
}

variable env_tag {
  type = "string"
  description = "environment tag"
  default = "stage"
}

variable machine_type {
  type = "string"
  description = "gcp machine type"
  default = "f1-small"
}
