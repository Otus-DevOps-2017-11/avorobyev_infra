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
  default     = {
    public = "~/.ssh/appuser.pub",
    private = "~/.ssh/appuser"
  }
}

variable zone {
  type        = "string"
  description = "GCP instance zone"
  default     = "europe-west1-d"
}
