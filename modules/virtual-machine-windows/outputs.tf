output "id" {
  value = azurerm_windows_virtual_machine.windows_virtual_machine[0].id
}

output "identity" {
  value = azurerm_windows_virtual_machine.windows_virtual_machine[0].identity
}

output "private_ip_address" {
  value = azurerm_windows_virtual_machine.windows_virtual_machine[0].private_ip_address
}