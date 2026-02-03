terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfdevbackend2026kr"
    container_name      = "tfstatekr"
    key                 = "dev.tfstate"
  }
}

provider "azurerm" {
  features {}
}