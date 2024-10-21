output "aci_cg_id" {
  value       = azurerm_container_group.main[0].id
  description = "ID of the container group"
}

output "aci_cg_ip" {
  value       = azurerm_container_group.main[0].ip_address
  description = "ID of the container group"
}

output "aci_cg_identity" {
  value       = azurerm_container_group.main[0].identity
  description = "System identity ID of the container group"
}

