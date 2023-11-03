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
