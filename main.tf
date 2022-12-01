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
  resource "azurerm_resource_group" "rg" {
  name     = "azure-terraform-rg"
  location = "West Europe"
  tags =  {
  env = "dev"
  cost = "TA102AXY"
  }
}


resource "azurerm_container_registry" "acr" {
  name                = "containerRegistry543456"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

