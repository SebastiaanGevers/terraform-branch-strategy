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

module "aks" {
  source = "./modules/aks"

  location = local.location
  prefix = var.prefix
  env_prefix = var.env_prefix
  resource_group_name = data.azurerm_resource_group.rg-tfworkshops.name
  virtual_network_name = azurerm_virtual_network.vn.name
  depends_on = [ azurerm_virtual_network.vn ]
  
}


module "datahub" {
  source = "./modules/datahub"

  datahub-prerequisites-values-file = var.datahub-prerequisites-values-file
  datahub-values-file               = var.datahub-values-file
  neo4j_username                    = var.neo4j_username
  neo4j_password                    = var.neo4j_password
  postgres_password                 = module.postgres.admin_password
  postgres_flexible_server_id       = module.postgres.server_id
  postgres_db_name                  = var.postgres_db_name
  postgres_fqdn                     = module.postgres.fqdn
  postgres_login                    = module.postgres.admin_login
  datahub_root_user                 = var.datahub_root_user
  datahub_root_user_password        = var.datahub_root_user_password

  depends_on = [module.aks, module.postgres]
}