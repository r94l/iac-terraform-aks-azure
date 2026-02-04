terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfstagebackend2026kr"
    container_name      = "tfstatekr"
    key                 = "stage.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
