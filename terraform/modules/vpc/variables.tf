variable source_ranges {
  type        = "list"
  description = "Адреса для доступа по ssh"
  default     = ["0.0.0.0/0"]
}

variable access_table {
  type = "list"
  description  = "records collection: tags_from, tags_to, ports"
  default = []
}

variable access_table_external {
  type = "list"
  description  = "records collection: tags_to, ports"
  default = []
}

variable env_tag {
  type = "string"
  description = "environment tag"
  default = "xxx"
}
