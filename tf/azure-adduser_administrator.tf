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


resource "azurerm_user_assigned_identity" "administrator-identity" {
  name                = "rg-tenpo-administrator-identity"
  location            = "East US"
  resource_group_name = "tenpo-resource-group"
}

# Creacion de usuario
resource "azurerm_user" "pablo_user" {
  name     = "pablo"
  password = "Password!"
  mail_alias = "pablo@tenpo.cl"
  user_principal_name = "pablo@tenpo.cl"
  identity {
    type        = "UserAssignedIdentity"
    identity_id = azurerm_user_assigned_identity.read_only_identity.id
  }
}

# Asignamiento de rol
resource "azurerm_role_assignment" "administrator_assignment" {
  scope                = data.azurerm_subscription.tenpo.id
  role_definition_name = "Global Administrator"
  principal_id         = data.azurerm_client_config.jcorola.object_id
}