locals {
  flex_vm_id                 = one(azurerm_linux_virtual_machine.linux_vm[*].id)
  flex_vm_name               = one(azurerm_linux_virtual_machine.linux_vm[*].name)
  flex_vm_private_ip_address = one(azurerm_linux_virtual_machine.linux_vm[*].private_ip_address)
  flex_vm_identity           = one(azurerm_linux_virtual_machine.linux_vm[*].identity)
}

output "vm_id" {
  description = "ID of VM"
  value       = local.flex_vm_id
}

output "vm_name" {
  description = "Name of VM"
  value       = local.flex_vm_name
}

output "vm_private_ip_address" {
  description = "Private IP of VM"
  value       = local.flex_vm_private_ip_address
}

output "vm_identity" {
  description = "Identity of VM"
  value       = local.flex_vm_identity
}