output "data_factory_id" {
  value       = azurerm_data_factory.data_factory.id
  description = "The ID of the Data Factory."
}

output "principal_id" {
  value       = azurerm_data_factory.data_factory.identity[0].principal_id
  description = "The Principal ID associated with this Managed Service Identity."

}