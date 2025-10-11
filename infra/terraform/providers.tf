terraform {
  required_version = ">= 1.9.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.120.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "80646857-9142-494b-90c5-32fea6acbc41"
}

