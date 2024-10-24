data "azurerm_resource_group" "rg-tfworkshops" {
  name = "Terraform-workshops"
}


locals {
 
  location = "francecentral"
}

resource "azurerm_virtual_network" "vn" {
  resource_group_name = data.azurerm_resource_group.rg-tfworkshops.name
  location            = local.location

  name          = "${var.prefix}-${var.env_prefix}-vn"
    address_space = ["10.0.0.0/8"]
}

# resource "azurerm_virtual_network" "vn" {
#   resource_group_name = data.azurerm_resource_group.rg-tfworkshops.name
#   location            = data.azurerm_resource_group.rg-tfworkshops.location

#   name          = "${var.prefix}-${var.env_prefix}-vn"
#   address_space = ["10.0.0.0/8"]
# }

# module "aks" {
#   source = "./modules/aks"

#   prefix = var.prefix
#   env_prefix = var.env_prefix
#   resource_group_name = data.azurerm_resource_group.rg-tfworkshops.name
#   virtual_network_name = azurerm_virtual_network.vn.name

#   depends_on = [ azurerm_virtual_network.vn ]
# }

# module "postgres" {
#   source = "./modules/postgres"

#   prefix = var.prefix
#   env_prefix = var.env_prefix
#   resource_group_name = data.azurerm_resource_group.rg-tfworkshops.name
#   virtual_network_name = azurerm_virtual_network.vn.name

#   postgres_admin_password = var.postgres_admin_password
#   server_zone = 1

#   depends_on = [ azurerm_virtual_network.vn ]
# }