output "external_ips" {
  value = "${google_compute_instance.gcp_instance.*.network_interface.0.access_config.0.assigned_nat_ip}"
}
