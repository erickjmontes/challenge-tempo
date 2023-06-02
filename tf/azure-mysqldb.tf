provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tenpo-mysql" {
  name                = "rg-tenpo-mysql"
  location            = "East US"
  resource_group_name = "tenpo-resource-group"
}

resource "azurerm_storage_account" "tenpo-storageaccount" {
  name                     = "lab-tenpo-storage"
  resource_group_name      = azurerm_resource_group.tenpo.name
  location                 = azurerm_resource_group.tenpo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_mssql_server" "lab-db01" {
  name                         = "tenpo-sqlserver"
  resource_group_name          = azurerm_resource_group.tenpo.name
  location                     = azurerm_resource_group.tenpo.location
  version                      = "12.0"
  administrator_login          = "admin"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}

resource "azurerm_mssql_database" "test" {
  name           = "db_lab01"
  server_id      = azurerm_mssql_server.tenpo.cl
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "S0"
  zone_redundant = true

  tags = {
    environment = "lab"
  }
}