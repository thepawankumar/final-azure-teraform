terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}
resource "azurerm_resource_group" "rg"  {
  name     = "example-resources"
   location = "West Europe"
}

resource  "azurerm_container_registry" "acr" {
   name                     =  "containerRegistry1"
   resource_group_name      =  azurerm_resource_group.rg.name
   location                 =  azurerm_resource_group.rg.location
  sku                       = "Standard"
   admin_enabled            = true
}




    resource "null_resource" "docker_push"  {
      provisioner "local-exec" {
       command = <<-EOT
        docker  login  ${azurerm_container_registry.acr.login_server}  
        docker push  ${azurerm_container_registry.acr.login_server}
       EOT
      }
    }
