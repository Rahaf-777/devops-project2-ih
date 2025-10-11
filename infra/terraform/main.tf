resource "azurerm_resource_group" "main" {
  name     = "rg-3tier-dev"
  location = "westeurope"

  tags = {
    environment = "dev"
    owner       = "rahaf"
    project     = "3tier"
  }
}

