 variable "prefix" {
  type = string
  description = "prefix value for all resources"
 }
 
 variable "env_prefix" { 
      type = string   
      description = "environment prefix for all resources"
}

variable "postgres_admin_password" {
  type = string
  sensitive = true
}

variable "postgres_server_zone" {
  type = string
  default = "2"
}

variable "datahub-prerequisites-values-file" {
  type = string
  default = "datahub-prerequisites-values.yaml"
}

variable "datahub-values-file" {
  type = string
  default = "datahub-values.yaml.tftpl"
}

variable "neo4j_password" {
  type = string
  sensitive = true
}

variable "neo4j_username" {
  type = string
  default = "datahub"
}

variable "postgres_db_name" {
  type = string
  default = "datahub"
}

variable "datahub_root_user" {
  type = string
  default = "datahub"
}

variable "datahub_root_user_password" {
  type = string
  sensitive = true
}