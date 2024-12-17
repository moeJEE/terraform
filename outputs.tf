output "resource_group_name" {
  value = azurerm_resource_group.document_processing.name
}

output "storage_account_name" {
  value = azurerm_storage_account.ocr_storage.name
}

output "cosmosdb_name" {
  value = azurerm_cosmosdb_account.cosmosdb_account.name
}

output "function_app_name" {
  value = azurerm_windows_function_app.ocr_function.name
}

output "cognitive_services_endpoint" {
  value = azurerm_cognitive_account.cognitive_services.endpoint
}

output "computer_vision_endpoint" {
  value = azurerm_cognitive_account.computer_vision.endpoint
}

output "static_web_app_url" {
  value = azurerm_static_site.frontend.default_hostname
}
