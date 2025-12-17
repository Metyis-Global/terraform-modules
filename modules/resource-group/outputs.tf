output "id" {
  value = (
    length(azurerm_resource_group.resource_group) > 0 ?
    azurerm_resource_group.resource_group.id : ""
  )
  description = "Resource identifier of the instance of Resource Group."
}

output "name" {
  value = (
    length(azurerm_resource_group.resource_group) > 0 ?
    azurerm_resource_group.resource_group.name : ""
  )
  description = "The name of the Resource Group."
}

output "location" {
  value = (
    length(azurerm_resource_group.resource_group) > 0 ?
    azurerm_resource_group.resource_group.location : ""
  )
  description = "Location assigned to the Resource Group."
}