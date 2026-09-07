terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "rg-secure-platform-dev"
  location = "Sweden Central"

  tags = {
    project     = "secure-azure-platform"
    environment = "dev"
    managed_by  = "terraform"
    owner       = "issa"
  }
}
resource "azurerm_virtual_network" "main" {
  name                = "vnet-secure-platform-dev"
  address_space       = ["10.10.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    project     = "secure-azure-platform"
    environment = "dev"
    managed_by  = "terraform"
    owner       = "issa"
  }
}

resource "azurerm_subnet" "main" {
  name                 = "snet-app-dev"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.10.1.0/24"]
}
resource "azurerm_container_registry" "main" {
  name                = "acrsecureplatformdev"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Standard"
  admin_enabled       = false

  tags = {
    project     = "secure-azure-platform"
    environment = "dev"
    managed_by  = "terraform"
    owner       = "issa"
  }
}
