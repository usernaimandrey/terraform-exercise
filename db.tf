# resource "yandex_mdb_postgresql_cluster" "dev-cluster" {
#   name        = var.db_cluster_name
#   environment = "PRESTABLE"
#   network_id  = yandex_vpc_network.network-1.id
#   security_group_ids = [yandex_vpc_security_group.dev_pg.id]

#   config {
#     version = 14
#     resources {
#       resource_preset_id = "s2.micro"
#       disk_type_id       = "network-ssd"
#       disk_size          = "15"
#     }

#     postgresql_config = {
#       max_connections    = 100
#     }
#   }
  
#   host {
#     zone = var.y_zone
#     name = var.db_host_name
#     subnet_id = yandex_vpc_subnet.subnet-1.id
#   }
# }

# resource "yandex_mdb_postgresql_user" "hexlet" {
#   cluster_id = yandex_mdb_postgresql_cluster.dev-cluster.id
#   name       = var.db_user
#   password   = var.db_password

#   depends_on = [ data.yandex_mdb_postgresql_cluster.db_cluster ]
# }

# resource "yandex_mdb_postgresql_database" "db1" {
#   cluster_id = yandex_mdb_postgresql_cluster.dev-cluster.id
#   name = "db1"
#   owner = yandex_mdb_postgresql_user.hexlet.name
#   lc_collate = "en_US.UTF-8"
#   lc_type    = "en_US.UTF-8"

#   depends_on = [ data.yandex_mdb_postgresql_cluster.db_cluster ]
# }

module "yandex-postgresql" {
  source      = "github.com/terraform-yc-modules/terraform-yc-postgresql?ref=1.0.2"
  network_id  = yandex_vpc_network.network-1.id
  name        = "tfhexlet"
  description = "Single-node PostgreSQL cluster"

  security_groups_ids_list = [yandex_vpc_security_group.dev_pg.id]

  hosts_definition = [
    {
      zone             = "ru-central1-a"
      assign_public_ip = false
      subnet_id        = yandex_vpc_subnet.subnet-1.id
    }
  ]

  postgresql_config = {
    max_connections = 100
  }

  databases = [
    {
      name       = "hexlet"
      owner      = var.db_user
      lc_collate = "ru_RU.UTF-8"
      lc_type    = "ru_RU.UTF-8"
      extensions = ["uuid-ossp", "xml2"]
    }
  ]

   owners = [
    {
      name       = var.db_user
      conn_limit = 15
    }
  ]

  users = [
    {
      name        = "guest"
      conn_limit  = 30
      permissions = ["hexlet"]
      settings = {
        pool_mode                   = "transaction"
        prepared_statements_pooling = true
      }
    }
  ]
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
