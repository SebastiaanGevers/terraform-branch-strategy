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

variable "location" {
  type = string
}