output "resource_id" {
  description = "Id of Log Analytics resource in Azure."
  value       = azurerm_log_analytics_workspace.logs_workspace.id
}

output "workspace_id" {
  description = "Log Analytics Workspace id, this is just a guid."
  value       = azurerm_log_analytics_workspace.logs_workspace.workspace_id
}

output "primary_shared_key" {
  description = "Log Analytics Workspace shared key"
  value       = azurerm_log_analytics_workspace.logs_workspace.primary_shared_key
}