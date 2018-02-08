variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable keys {
  description = "Paths to the keys used for ssh access"
  type        = "map"
  default     = {}
}

variable zone {
  type        = "string"
  description = "GCP instance zone"
  default     = "europe-west1-d"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable db_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-db-base"
}

variable adm_ip_range {
  type = "string"
  description = "ip allowed for admins"
  default = "0.0.0.0/32"
}
