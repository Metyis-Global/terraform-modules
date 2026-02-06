output "association_id" {
  value = one(azurerm_subnet_network_security_group_association.associations[*].id)
}