output "external_ip" {
  value = [yandex_compute_instance_group.devops.instances[*].network_interface[0].nat_ip_address]
}

output "internal_ip" {
  value = [yandex_compute_instance_group.devops.instances[*].network_interface[0].ip_address]
}

# output "internal_ip_address_webserver" {
#   value = yandex_compute_instance.webserver.network_interface.0.ip_address
# }

# output "external_ip_address_webserver" {
#   value = yandex_compute_instance.webserver.network_interface.0.nat_ip_address
# }

# output "internal_ip_address_appserver" {
#   value = yandex_compute_instance.appserver.network_interface.0.ip_address
# }

# output "external_ip_address_appserver" {
#   value = yandex_compute_instance.appserver.network_interface.0.nat_ip_address
# }
