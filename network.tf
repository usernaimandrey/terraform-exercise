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
