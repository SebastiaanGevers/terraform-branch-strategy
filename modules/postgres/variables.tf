variable "prefix" {
  type = string
  description = "prefix value for all resources"
}

variable "env_prefix" {
  type = string
  description = "environment prefix for all resources"
}

variable "resource_group_name" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "postgres_admin_login" {
  type = string
  default = "psqladmin"
}

variable "postgres_admin_password" {
  type = string
  sensitive = true
}

variable "server_zone" {
  type = string
  default = "2"
}

variable "server_storage" {
  type = number
  default = 32768
}

variable "storage_tier" {
  type = string
  default = "P4"
}

variable "storage_auto_grow" {
  type = bool
  default = true
}

variable "server_sku" {
  type = string
  default = "B_Standard_B1ms"
}
variable "location" {
  type = string
}