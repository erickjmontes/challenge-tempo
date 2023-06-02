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

resource "azurerm_user_assigned_identity" "read_only_identity" {
  name                = "rg-tenpo-read-only-identity"
  location            = "East US"
  resource_group_name = "tenpo-resource-group"
}

# Creacion de usuario
resource "azurerm_user" "jorge_user" {
  name     = "jorge"
  password = "Password!"
  mail_alias = "jorge@tenpo.cl"
  user_principal_name = "jorge@tenpo.cl"
  identity {
    type        = "UserAssignedIdentity"
    identity_id = azurerm_user_assigned_identity.read_only_identity.id
  }
}

# Asignamiento de rol
resource "azurerm_role_assignment" "assign_read_only_role" {
  scope                = "/subscriptions/<subscription_id>/resourceGroups/my-resource-group"
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.read_only_identity.principal_id
}