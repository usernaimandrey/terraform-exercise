resource "yandex_alb_load_balancer" "dev-1" {
  name               = "dev-1"
  network_id         = yandex_vpc_network.network-1.id
  # security_group_ids = [yandex_vpc_security_group.dev-sg.id]

  allocation_policy {
    location {
      zone_id   = var.y_zone
      subnet_id = yandex_vpc_subnet.subnet-1.id
    }

    location {
      zone_id   = var.y_zone_b
      subnet_id = yandex_vpc_subnet.subnet-2.id
    }

    location {
      zone_id   = var.y_zone_c
      subnet_id = yandex_vpc_subnet.subnet-3.id
    }
  }

  listener {
    name = "alb-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.dev-router.id
      }
    }
  }
}
