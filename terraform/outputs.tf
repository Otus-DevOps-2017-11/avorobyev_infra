output "app_external_ip" {
  value = "${module.app.external_ip}"
}

output "db_external_ip" {
  value = "${module.db.external_ip}"
}

output "keyring" {
  value = "${google_compute_project_metadata_item.project_keys.value}"
}
