provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tenpo-sa" {
  name     = "rg-tenpo-sa"
  location = "Brazil South"
}

resource "azurerm_storage_account" "tenpo-storageaccount" {
  name                     = "lab-tenpo-storage"
  resource_group_name      = azurerm_resource_group.tenpo.name
  location                 = azurerm_resource_group.tenpo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "lab"
  }
}