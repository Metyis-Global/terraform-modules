output "subnet_id" {
  description = "The subnet ID"
  value       = join("", azurerm_subnet.snet.*.id)
}

output "subnet_name" {
  description = "The subnet name"
  value       = join("", azurerm_subnet.snet.*.name)
}

output "virtual_network_name" {
  description = "The name of the virtual network in which the subnet is created in"
  value       = join("", azurerm_subnet.snet.*.virtual_network_name)
}

output "resource_group_name" {
  description = "The name of the resource group in which the subnet is created in"
  value       = join("", azurerm_subnet.snet.*.resource_group_name)
}

output "subnet_address_prefixes" {
  description = "The address prefixes for the subnet"
  value       = azurerm_subnet.snet.*.address_prefixes
}
