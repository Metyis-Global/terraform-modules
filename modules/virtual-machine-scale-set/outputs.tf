output "vmss_id" {
  value = azurerm_linux_virtual_machine_scale_set.main.id
}

/*output "vmss_principal_id" {
  value = azurerm_linux_virtual_machine_scale_set.main.identity.0.principal_id
}*/