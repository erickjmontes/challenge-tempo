provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tempo" {
  name     = "tempo-resources"
  location = "Brazil South"
}

resource "azurerm_storage_account" "tempo-storageaccount" {
  name                     = "lab-tempo-storage"
  resource_group_name      = azurerm_resource_group.tempo.name
  location                 = azurerm_resource_group.tempo.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "testing"
  }
}