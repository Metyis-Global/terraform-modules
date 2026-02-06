output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "rg_id" {
  value       = azurerm_resource_group.main.id
  description = "The ID of the resource group"
}

output "rg_name" {
  value       = azurerm_resource_group.main.name
  description = "The name of the resource group"
}
