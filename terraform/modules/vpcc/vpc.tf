
resource "google_compute_firewall" "firewall_brick_from_all" {

  count = "${ length(var.access_table_from_all) }"

  name    = "fw-rule-${count.index}"

  network = "default"

  allow {
    protocol = "tcp"
    ports    = "${ split(",", lookup(var.access_table_from_all[count.index], "ports")) }"
  }

  # правило применимо к инстансам с тегом ...
  target_tags = "${split(",", lookup(var.access_table_from_all[count.index],"tags_to"))}"
}

resource "google_compute_firewall" "firewall_brick" {

  count = "${ length(var.access_table) }"

  name    = "fw-rule-${google_compute_firewall.firewall_brick_from_all.count + count.index}"

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
