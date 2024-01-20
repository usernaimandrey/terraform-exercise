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

variable "y_service_account_id" {
  description = "service account id"
  type        = string
  sensitive   = true
}

variable "y_zone" {
  description = "zone for virtula machine"
  type        = string
  default     = "ru-central1-a"
}

variable "y_zone_b" {
  type = string
  default = "ru-central1-b"
}

variable "y_zone_c" {
  type = string
  default = "ru-central1-c"
}

variable "y_image_id_container" {
  description = "image with docker"
  type        = string
  default     = "fd8le4hl5jhi2qdrtpv5"
}

variable "y_network_name" {
  description = "network name"
  type        = string
  default     = "network1"
}

variable "subnet_name1" {
  description = "subnet name"
  type        = string
  default     = "subnet1"
}

variable "subnet_name2" {
  description = "subnet name"
  type        = string
  default     = "subnet2"
}

variable "subnet_name3" {
  description = "subnet name"
  type        = string
  default     = "subnet3"
}

variable "y_v4_cidr_blocks1" {
  description = "block ip"
  type        = list(string)
  default     = [ "192.168.1.0/24"]
}

variable "y_v4_cidr_blocks2" {
  description = "block ip"
  type        = list(string)
  default     = [ "192.168.2.0/24"]
}

variable "y_v4_cidr_blocks3" {
  description = "block ip"
  type        = list(string)
  default     = [ "192.168.3.0/24"]
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

variable "meta_data" {
  type = string
}

variable "declaration" {
  type = string
}

variable "domain" {
  type = string
}

variable "db_cluster_name" {
  type      = string
  sensitive = true
}

variable "db_host_name" {
  type      = string
  sensitive = true
}

variable "db_user" {
  type      = string
}

variable "db_password" {
  type      = string
  sensitive = true
}
