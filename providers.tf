provider "azurerm" {
  features {}
  use_oidc = true
}

provider "kubernetes" {
  # Configuration options
}

provider "helm" {
  # Configuration options
}