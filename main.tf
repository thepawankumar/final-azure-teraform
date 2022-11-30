terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }

# backend "azurerm" {
 #   resource_group_name  = "friday-demo-rg"
  #  storage_account_name = "sttfstatemgt01"
   # container_name       = "tfstate"
   # key                  = "demo.terraform.tfstate"
 # }
 }

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  # subscription_id = var.subscription_id
  # client_id       = var.client_id
  # client_secret   = var.client_secret
  # tenant_id       = var.tenant_id
}


# Create a resource group
#resource "azurerm_resource_group" "rg" {
 # name     = "demo-rg"
  #location = "West Europe"
  #tags =  {
   # env = "dev"
    #cost = "TA102AXY"
  #}
#}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_container_registry" "acr" {
  name                = "containerRegistry1"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Premium"
  admin_enabled       = false
  georeplications {
    location                = "East US"
    zone_redundancy_enabled = true
    tags                    = {}
  }
  georeplications {
    location                = "North Europe"
    zone_redundancy_enabled = true
    tags                    = {}
  }
}
