variable "datahub-prerequisites-values-file" {
  type = string
}

variable "datahub-values-file" {
  type = string
}

variable "neo4j_username" {
  type = string
}

variable "neo4j_password" {
  type = string
  sensitive = true
}

variable "postgres_password" {
  type = string
  sensitive = true
}

variable "postgres_flexible_server_id" {
  type = string
}

variable "postgres_db_name" {
  type = string
  default = "datahub"
}

variable "postgres_login" {
  type = string
  default = "datahub"
}

variable "postgres_fqdn" {
  type = string
}

variable "postgres_port" {
  type = number
  default = 5432
}

variable "datahub_root_user" {
  type = string
  default = "datahub"
}

variable "datahub_root_user_password" {
  type = string
  sensitive = true
}