output "admin_login" {
  value = postgres.admin_login
}

output "admin_password" {
  sensitive = true
  value = postgres.admin_password
}

output "fqdn" {
  value = azurerm_postgresql_flexible_server.postgres.fqdn
}

output "server_id" {
  value = azurerm_postgresql_flexible_server.postgres.id
}