# resource "yandex_vpc_security_group" "dev-sg" {
#   name        = "dev-sg"
#   network_id  = yandex_vpc_network.network-1.id

#   egress {
#     protocol       = "ANY"
#     description    = "any"
#     v4_cidr_blocks = ["0.0.0.0/0"]
#     from_port      = 1
#     to_port        = 65535
#   }

#   ingress {
#     protocol       = "TCP"
#     description    = "ext-http"
#     v4_cidr_blocks = ["0.0.0.0/0"]
#     port           = 80
#   }

#   ingress {
#     protocol       = "TCP"
#     description    = "ext-https"
#     v4_cidr_blocks = ["0.0.0.0/0"]
#     port           = 443
#   }

#   ingress {
#     protocol          = "TCP"
#     description       = "healthchecks"
#     predefined_target = "loadbalancer_healthchecks"
#     port              = 30080
#   }
# }


# resource "yandex_alb_load_balancer" "dev-1" {
#   name               = "dev-1"
#   network_id         = yandex_vpc_network.network-1.id
#   security_group_ids = [yandex_vpc_security_group.dev-sg.id]

#   allocation_policy {
#     location {
#       zone_id   = var.y_zone
#       subnet_id = yandex_vpc_subnet.subnet-1.id
#     }

#     location {
#       zone_id   = var.y_zone_b
#       subnet_id = yandex_vpc_subnet.subnet-2.id
#     }

#     location {
#       zone_id   = var.y_zone_c
#       subnet_id = yandex_vpc_subnet.subnet-3.id
#     }
#   }

#   listener {
#     name = "alb-listener"
#     endpoint {
#       address {
#         external_ipv4_address {
#         }
#       }
#       ports = [ 80 ]
#     }
#     http {
#       handler {
#         http_router_id = yandex_alb_http_router.dev-router.id
#       }
#     }
#   }
# }

# resource "yandex_alb_http_router" "dev-router" {
#   name   = "dev-router"
# }

# resource "yandex_alb_virtual_host" "dev-host" {
#   name           = "dev-host"
#   http_router_id = yandex_alb_http_router.dev-router.id
#   authority      = [var.domain, "www.${var.domain}"]
#   route {
#     name = "route-1"
#     http_route {
#       http_route_action {
#         backend_group_id = yandex_alb_backend_group.dev-bg.id
#       }
#     }
#   }
# }
