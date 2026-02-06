output "vm_id" {
  description = "ID of VM"
  value       = azurerm_linux_virtual_machine.linux_vm.id
}

output "vm_name" {
  description = "Name of VM"
  value       = azurerm_linux_virtual_machine.linux_vm.name
}

output "vm_private_ip_address" {
  description = "Private IP of VM"
  value       = azurerm_linux_virtual_machine.linux_vm.private_ip_address
}

output "vm_public_ip_address" {
  description = "Public IP of VM"
  value       = azurerm_public_ip.pip_vm.ip_address
}

output "vm_identity" {
  description = "Identity of VM"
  value       = azurerm_linux_virtual_machine.linux_vm.identity
}