output "natgw_id" {
  description = "ID of NAT gateway"
  value       = azurerm_nat_gateway.natgw.id
}

output "natgw_resource_guid" {
  description = "Resource_guid of NAT gateway"
  value       = azurerm_nat_gateway.natgw.resource_guid
}
