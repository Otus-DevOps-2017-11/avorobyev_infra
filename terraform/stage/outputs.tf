output "app_external_ip" {
  value = "${module.nodes.external_ips[0]}"
}

output "db_external_ip" {
  value = "${module.nodes.external_ips[1]}"
}
