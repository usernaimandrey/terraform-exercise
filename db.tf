resource "yandex_mdb_postgresql_cluster" "dev-cluster" {
  name        = "dev-cluster"
  environment = "PRODUCTION"
  network_id  = yandex_vpc_network.network-1.id
  security_group_ids = [yandex_vpc_security_group.dev_pg.id]

  config {
    version = 14
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = "20"
    }
  }
  
  host {
    zone = var.y_zone
    name = "dev-pg-host"
    subnet_id = yandex_vpc_subnet.subnet-1.id
  }
}

resource "yandex_mdb_postgresql_user" "hexlet" {
  cluster_id = yandex_mdb_postgresql_cluster.dev-cluster.id
  name       = var.db_user
  password   = var.db_password
}

resource "yandex_mdb_postgresql_database" "db1" {
  cluster_id = yandex_mdb_postgresql_cluster.dev-cluster.id
  name = "db1"
  owner = "hexlet"
}
