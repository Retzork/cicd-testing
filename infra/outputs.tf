output "web_app_url" {
  value = "https://${azurerm_linux_web_app.app.default_hostname}"
}

output "web_app_name" {
  value = azurerm_linux_web_app.app.name
}
