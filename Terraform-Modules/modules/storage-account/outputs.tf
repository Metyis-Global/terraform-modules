output "storage_account_id" {
  value       = azurerm_storage_account.storage_account.id
  description = "The ID of the storage account"
}

output "storage_account_name" {
  value       = azurerm_storage_account.storage_account.name
  description = "The Name of the storage account"
}

output "storage_account_storage_account_access_key" {
  value       = azurerm_storage_account.storage_account.primary_access_key
  description = "Storage account access key"
}