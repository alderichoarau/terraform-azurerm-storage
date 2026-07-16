terraform {
  required_version = ">= 1.9"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  storage_use_azuread = true
}

resource "azurerm_resource_group" "example" {
  name     = "rg-example-storage"
  location = "francecentral"
}

module "storage" {
  source = "github.com/alderichoarau/terraform-azurerm-storage"

  name                = "stexample"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  tags = {
    owner = "example"
  }
}

output "storage_account_name" {
  value = module.storage.storage_account_name
}
