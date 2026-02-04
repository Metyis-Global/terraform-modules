output "aut_account_name" {
  description = "The name of this Automation account."
  value       = azurerm_automation_account.automation_account.name
}

output "account_id" {
  description = "The ID of this Automation account."
  value       = azurerm_automation_account.automation_account.id
}