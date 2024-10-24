data "azurerm_resource_group" "rg-tfworkshops" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vn" {
  name = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.rg-tfworkshops.name
}

resource "azurerm_subnet" "nodepool-sn" {
  name                 = "nodepool-sn"
  resource_group_name  = data.azurerm_resource_group.rg-tfworkshops.name
  virtual_network_name = data.azurerm_virtual_network.vn.name
  address_prefixes     = ["10.1.0.0/16"]
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-${var.env_prefix}-aks"
  dns_prefix          = "${var.prefix}-${var.env_prefix}"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg-tfworkshops.name

  default_node_pool {
    name           = "default"
    node_count     = 3
    vm_size        = "Standard_D2_v3"
    type           = "VirtualMachineScaleSets"
    vnet_subnet_id = azurerm_subnet.nodepool-sn.id
  }

  identity {
    type = "SystemAssigned"
  }

  sku_tier = "Standard"
}