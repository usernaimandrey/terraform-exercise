data "yandex_compute_image" "container-optimized-image" {
  family = "container-optimized-image"
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

data "yandex_compute_image" "centos" {
  family = "centos-7"
}

# data "yandex_mdb_postgresql_cluster" "db_cluster" {
#   name = var.db_cluster_name

#   depends_on = [ yandex_mdb_postgresql_cluster.dev-cluster ]
# }

# data "shell_script" "db" {
#   lifecycle_commands {
#     read = <<-EOF
#     echo {db: "${data.yandex_mdb_postgresql_cluster.db_cluster.host.0.fqdn}"}
#     EOF
#   }

#   depends_on = [ data.yandex_mdb_postgresql_cluster.db_cluster ]
# }

# output "db" {
#   value = data.yandex_mdb_postgresql_cluster.db_cluster.host.0.fqdn
# }

# resource "yandex_compute_instance_group" "devops" {
#   name = "devops-for-programmers"
#   folder_id = var.y_folder_id
#   service_account_id = var.y_service_account_id
#   instance_template {
#     platform_id = "standard-v3"
#     resources {
#       memory = var.memory_count
#       cores  = var.cores_count
#     }
#     boot_disk {
#       mode = "READ_WRITE"
#       initialize_params {
#         image_id = data.yandex_compute_image.container-optimized-image.id
#       }
#     }
#     network_interface {
#       network_id         = yandex_vpc_network.network-1.id
#       subnet_ids         = [yandex_vpc_subnet.subnet-1.id, yandex_vpc_subnet.subnet-2.id, yandex_vpc_subnet.subnet-3.id]
#       nat                = true
#       security_group_ids = [yandex_vpc_security_group.dev-vm-sg.id]
#     }
#     metadata = {
#       docker-container-declaration = "${file(var.declaration)}" 
#       user-data =  "${file(var.meta_data)}"
#     }
#   }
#   scale_policy {
#     fixed_scale {
#       size = 2
#     }
#   }
#   allocation_policy {
#     zones = [var.y_zone, var.y_zone_b, var.y_zone_c]
#   }
#   deploy_policy {
#     max_unavailable = 2
#     max_creating = 2
#     max_expansion = 2
#     max_deleting = 2
#   }
#   application_load_balancer {
#     target_group_name = "dev-tg"
#   }
# }

# resource "yandex_alb_backend_group" "dev-bg" {
#   name                     = "alb-bg"

#   http_backend {
#     name                   = "backend-1"
#     port                   = 80
#     target_group_ids       = [yandex_compute_instance_group.devops.application_load_balancer.0.target_group_id]
#     healthcheck {
#       timeout              = "10s"
#       interval             = "2s"
#       healthcheck_port     = 80
#       http_healthcheck {
#         path               = "/"
#       }
#     }
#   }
# }

# resource "yandex_vpc_security_group" "dev-vm-sg" {
#   name        = "dev-vm-sg"
#   network_id  = yandex_vpc_network.network-1.id

#   ingress {
#     protocol          = "TCP"
#     description       = "balancer"
#     security_group_id = yandex_vpc_security_group.dev-sg.id
#     port              = 80
#   }

#   ingress {
#     protocol       = "TCP"
#     description    = "ssh"
#     v4_cidr_blocks = ["0.0.0.0/0"]
#     port           = 22
#   }
# }

resource "yandex_compute_instance" "webserver" {
  name = var.y_instanse_name_1

  resources {
    cores  = var.cores_count
    memory = var.memory_count
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.container-optimized-image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  connection {
    type = "ssh"
    user = "andery"
    private_key = file("~/.ssh/id_rsa")
    host = self.network_interface[0].nat_ip_address
  }

  provisioner "remote-exec" {
    inline = [
      <<EOT
      export DB_HOST="${module.yandex-postgresql.cluster_fqdns_list[0].0}"
      EOT
    ]
  }

  metadata = {
    user-data = "${file(var.meta_data)}"
    # ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
  depends_on = [ module.yandex-postgresql ]
}

resource "yandex_compute_instance" "appserver" {
  name = var.y_instanse_name_2

  resources {
    cores  = var.cores_count
    memory = var.memory_count
  }

  boot_disk {
    initialize_params {
      # image_id = var.y_image_id_centos
      image_id = data.yandex_compute_image.container-optimized-image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  connection {
    type = "ssh"
    user = "andery"
    private_key = file("~/.ssh/id_rsa")
    host = self.network_interface[0].nat_ip_address
  }

  provisioner "remote-exec" {
    inline = [
      <<EOT
      export DB_HOST="${module.yandex-postgresql.cluster_fqdns_list[0].0}"
      EOT
    ]
  }

  metadata = {
    user-data = "${file(var.meta_data)}"
    # ssh-keys = "centos:${file("~/.ssh/id_ed25519.pub")}"
  }
  depends_on = [ module.yandex-postgresql ]
}
