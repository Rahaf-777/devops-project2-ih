terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "rahafstorage20251005"
    container_name       = "tfstate"
    key                  = "3tier/dev/terraform.tfstate"
  }
}

