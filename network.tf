resource "yandex_vpc_network" "network-1" {
  name = var.y_network_name
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = var.subnet_name1
  zone           = var.y_zone
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = var.y_v4_cidr_blocks1
}

resource "yandex_vpc_subnet" "subnet-2" {
  name           = var.subnet_name2
  zone           = var.y_zone_b
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = var.y_v4_cidr_blocks2
}

resource "yandex_vpc_subnet" "subnet-3" {
  name           = var.subnet_name3
  zone           = var.y_zone_c
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = var.y_v4_cidr_blocks3
}

resource "yandex_vpc_security_group" "dev-sg" {
  name        = "dev-sg"
  network_id  = yandex_vpc_network.network-1.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 1
    to_port        = 65535
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-http"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-https"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    protocol          = "TCP"
    description       = "healthchecks"
    predefined_target = "loadbalancer_healthchecks"
    port              = 30080
  }
}

resource "yandex_vpc_security_group" "dev-vm-sg" {
  name        = "dev-vm-sg"
  network_id  = yandex_vpc_network.network-1.id

  ingress {
    protocol          = "TCP"
    description       = "balancer"
    security_group_id = yandex_vpc_security_group.dev-sg.id
    port              = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }
}

resource "yandex_vpc_security_group" "dev_pg" {
  name = "dev-pg"
  network_id = yandex_vpc_network.network-1.id

  ingress {
    description = "Postgres"
    port        = 6432
    protocol = "TCP"
    v4_cidr_blocks = [ "0.0.0.0/0" ]
  }
}

resource "yandex_alb_http_router" "dev-router" {
  name   = "dev-router"
}

resource "yandex_alb_virtual_host" "dev-host" {
  name           = "dev-host"
  http_router_id = yandex_alb_http_router.dev-router.id
  authority      = [var.domain, "www.${var.domain}"]
  route {
    name = "route-1"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.dev-bg.id
      }
    }
  }
}
