resource "google_compute_firewall" "incoming_ssh" {
  name    = "default-allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "firewall_puma" {

  name = "allow-puma-default"

  # Название сети, в которой действует правило
  network = "default"

  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]

  # Правило применимо для инстансов с тегом ...
  target_tags = ["reddit-app"]
}
