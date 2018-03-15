
resource "google_compute_firewall" "wallbrick_external" {

  count = "${ length(var.access_table_external) }"

  name    = "fw-rule-${var.env_tag}-${count.index}"

  network = "default"

  allow {
    protocol = "tcp"
    ports    = "${ split(",", lookup(var.access_table_external[count.index], "ports")) }"
  }

  # правило применимо к инстансам с тегом ...
  target_tags = "${split(",", lookup(var.access_table_external[count.index],"tags_to"))}"

  # порт будет доступен отовсюду
}

resource "google_compute_firewall" "wallbrick" {

  count = "${ length(var.access_table) }"

  name    = "fw-rule-${var.env_tag}-${google_compute_firewall.wallbrick_external.count + count.index}"

  network = "default"

  allow {
    protocol = "tcp"
    ports    = "${ split(",", lookup(var.access_table[count.index], "ports")) }"
  }

  # правило применимо к инстансам с тегом ...
  target_tags = "${split(",", lookup(var.access_table[count.index],"tags_to"))}"

  # порт будет доступен только для инстансов с тегом ...
  source_tags = "${ split(",", lookup(var.access_table[count.index],"tags_from")) }"
}
