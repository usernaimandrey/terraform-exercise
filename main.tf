terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token                    = var.y_token
  cloud_id                 = var.y_cloud_id
  folder_id                = var.y_folder_id
  zone                     = var.y_zone
}

# resource "yandex_iam_service_account" "terraform" {
#   name        = "terraform"
#   description = "terraform exercise"
#  }

resource "yandex_compute_instance" "webserver" {
  name = var.y_instanse_name_1

  resources {
    cores  = var.cores_count
    memory = var.memory_count
  }

  boot_disk {
    initialize_params {
      image_id = var.y_image_id_ubuntu
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data = "${file(var.meta_data)}"
    # ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}

# resource "yandex_compute_instance" "appserver" {
#   name = var.y_instanse_name_2

#   resources {
#     cores  = var.cores_count
#     memory = var.memory_count
#   }

#   boot_disk {
#     initialize_params {
#       image_id = var.y_image_id_centos
#     }
#   }

#   network_interface {
#     subnet_id = yandex_vpc_subnet.subnet-1.id
#     nat       = true
#   }

#   metadata = {
#     user-data = "${file(var.meta_data)}"
#     # ssh-keys = "centos:${file("~/.ssh/id_ed25519.pub")}"
#   }
# }

resource "yandex_vpc_network" "network-1" {
  name = var.y_network_name
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = var.subnet_name
  zone           = var.y_zone
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = var.y_v4_cidr_blocks
}

output "internal_ip_address_webserver" {
  value = yandex_compute_instance.webserver.network_interface.0.ip_address
}

output "external_ip_address_webserver" {
  value = yandex_compute_instance.webserver.network_interface.0.nat_ip_address
}

# output "internal_ip_address_appserver" {
#   value = yandex_compute_instance.appserver.network_interface.0.ip_address
# }

# output "external_ip_address_appserver" {
#   value = yandex_compute_instance.appserver.network_interface.0.nat_ip_address
# }
