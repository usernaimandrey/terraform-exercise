# resource "yandex_dns_zone" "zone-1" {
#   name   = "anshlyapnikov-zone"
#   zone   =  var.domain
#   public = true 
# }

# resource "yandex_dns_recordset" "anshlyapnikov" {
#   zone_id = yandex_dns_zone.zone-1.id
#   name    = var.domain
#   type    = "A"
#   ttl     = 600
#   data    = [yandex_alb_load_balancer.dev-1.listener[0].endpoint[0].address[0].external_ipv4_address[0].address]
# }

# resource "yandex_dns_recordset" "www_anshlyapnikov" {
#   zone_id = yandex_dns_zone.zone-1.id
#   name    = "www"
#   type    = "CNAME"
#   ttl     = 600
#   data    = [var.domain]
# }
