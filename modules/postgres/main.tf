data "azurerm_resource_group" "rg-tfworkshops" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vn" {
  name = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.rg-tfworkshops.name
}

resource "azurerm_subnet" "postgres-sn" {
  name                 = "postgres-sn"
  resource_group_name  = data.azurerm_resource_group.rg-tfworkshops.name
  virtual_network_name = data.azurerm_virtual_network.vn.name
  address_prefixes     = ["10.2.0.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_private_dns_zone" "postgres-dns-zone" {
  name = "${var.prefix}.${var.env_prefix}.postgres.database.azure.com"
  resource_group_name = data.azurerm_resource_group.rg-tfworkshops.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres-dns-zone-link" {
  name = "${var.prefix}-${var.env_prefix}-vnet-postgres-link"
  private_dns_zone_name = azurerm_private_dns_zone.postgres-dns-zone.name
  virtual_network_id = data.azurerm_virtual_network.vn.id
  resource_group_name = data.azurerm_resource_group.rg-tfworkshops.name
}

resource "azurerm_postgresql_flexible_server" "postgres" {
  name                          = "${var.prefix}-${var.env_prefix}-postgres"
  resource_group_name           = data.azurerm_resource_group.rg-tfworkshops.name
  location                      = var.location
  version                       = "16"
  delegated_subnet_id           = azurerm_subnet.postgres-sn.id
  private_dns_zone_id           = azurerm_private_dns_zone.postgres-dns-zone.id
  public_network_access_enabled = false
  administrator_login           = var.postgres_admin_login
  administrator_password        = var.postgres_admin_password
  zone                          = var.server_zone

  storage_mb   = var.server_storage
  storage_tier = var.storage_tier
  auto_grow_enabled = var.storage_auto_grow
  

  sku_name   = var.server_sku
  depends_on = [azurerm_private_dns_zone_virtual_network_link.postgres-dns-zone-link]

}