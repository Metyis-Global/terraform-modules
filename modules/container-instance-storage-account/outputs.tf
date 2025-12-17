output "storage_account_id" {
  value       = azurerm_storage_account.main.id
  description = "The ID of the storage account"
}

output "storage_account_name" {
  value       = azurerm_storage_account.main.name
  description = "The Name of the storage account"
}

output "storage_account_storage_account_access_key" {
  value       = azurerm_storage_account.main.primary_access_key
  description = "Storage account access key"
}