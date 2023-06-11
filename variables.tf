variable "y_token" {
  description = "AIM token time to live not more 12 hours"
  type        = string
  sensitive   = true
}

variable "y_cloud_id" {
  description = "id cloud"
  type        = string
  sensitive   = true
}

variable "y_folder_id" {
  description = "id folder"
  type        = string
  sensitive   = true
}

variable "y_zone" {
  description = "zone for virtula machine"
  type        = string
  default     = "ru-central1-a"
}

variable "y_image_id_ubuntu" {
  description = "image ubuntu"
  type        = string
  default     = "fd807ed79a4kkqfvd1mb"
}

variable "y_image_id_centos" {
  description = "image centos"
  type        = string
  default     = "fd8dgtuscndkp3jmdb82"
}

variable "y_network_name" {
  description = "network name"
  type        = string
  default     = "network1"
}

variable "subnet_name" {
  description = "subnet name"
  type        = string
  default     = "subnet1"
}

variable "y_v4_cidr_blocks" {
  description = "block ip"
  type        = list(string)
  default     = [ "192.168.10.0/24"]
}

variable "y_instanse_name_1" {
  description = "name vm 1"
  type        = string
  default     = "terraform1"
}

variable "y_instanse_name_2" {
  description = "name vm 2"
  type        = string
  default = "terraform2"
}

variable "cores_count" {
  type    = number
  default = 2
}

variable "memory_count" {
  type    = number
  default = 2
}

variable "y_user_id" {
  type      = string
  sensitive = true
}
