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

resource  "azurerm_azuread_application" "acr-app"  {
  name = "acr-app"
}

resource  "azurerm_azuread_service_principal"  "acr-sp" {
  application_id =  "${azurerm_azuread_application.acr-app.application_id}"
}

resource  "azurerm_azuread_service_principal_password"  "acr-sp-pass" {
  service_principal_id =  "${azurerm_azuread_service_principal.acr-sp.id}"
   value                = "Password12345"
   end_date             =  "2024-01-01T01:02:03Z"
}

resource  "azurerm_role_assignment"  "acr-assignment" {
  scope                 =  "${azurerm_container_registry.acr.id}"
   role_definition_name = "Contributor"
   principal_id         =  "${azurerm_azuread_service_principal_password.acr-sp-pass.service_principal_id}"
}

    resource "null_resource" "docker_push"  {
      provisioner "local-exec" {
       command = <<-EOT
        docker  login  ${azurerm_container_registry.acr.login_server}  
        docker push  ${azurerm_container_registry.acr.login_server}
       EOT
      }
    }
