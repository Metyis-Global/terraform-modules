output "wan_id" {
  description = "The WAN ID"
  value       = azurerm_virtual_wan.wan.id
}

output "wan_name" {
  description = "The WAN name"
  value       = azurerm_virtual_wan.wan.name
}

output "vhub_id" {
  description = "The virtual hub ID"
  value       = azurerm_virtual_hub.hub.id
}

output "vhub_name" {
  description = "The virtual hub name"
  value       = azurerm_virtual_hub.hub.name
}
