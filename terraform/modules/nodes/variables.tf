variable zone {
  type        = "string"
  description = "GCP instance zone"
  default     = "europe-west1-d"
}

variable keys {
  description = "Paths to the keys used for ssh access"
  type        = "map"
  default     = {}
}

variable instances {
  type = "list"
  description = "instance params: name, machine_type, disk_image, tags"
  default = []
}
