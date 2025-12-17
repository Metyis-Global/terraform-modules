output "instrumentation_key" {
  value       = azurerm_application_insights.main.instrumentation_key
  description = "The Instrumentation Key for this Application Insights component."
}

output "app_id" {
  value       = azurerm_application_insights.main.app_id
  description = "The App ID associated with this Application Insights component"
}

output "id" {
  value       = azurerm_application_insights.main.id
  description = "The ID of the Application Insights component"
}

output "connection_string" {
  value       = azurerm_application_insights.main.connection_string
  description = "Connection_string of the Application Insights component"
}

 