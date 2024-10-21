output "pe_id" {
  value       = azurerm_private_endpoint.main.id
  description = "Id of private endpoint"
}

output "pe_name" {
  value       = azurerm_private_endpoint.main.name
  description = "Name of private endpoint"
}