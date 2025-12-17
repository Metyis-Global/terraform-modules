output "cost_management_id" {
  value       = azurerm_subscription_cost_management_export.cost_management_export.id
  description = "The ID of the Cost Management Export for this Subscription."
}