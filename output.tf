## container registry
output "container_registry_login" {
  value = azurerm_container_registry.acr[0].login_server
}