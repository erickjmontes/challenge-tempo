terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.15.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Creacion de usuario
resource "azuread_user" "new_user" {
  user_principal_name = "jorge.corola@tenpo.cl"
  display_name        = "Jorge"
  mail_nickname       = "jcorola"
  password            = "BadPassword789-#!"
}

# Asignamiento de rol
resource "azurerm_role_assignment" "reader_assignment" {
  scope                = data.azurerm_subscription.tenpo.id
  role_definition_name = "Reader"
  principal_id         = data.azurerm_client_config.jcorola.object_id
}