resource "random_password" "random_password" {
  length           = 24
  special          = true
  override_special = "~!@#$%^&*_-+=|(){}[]:;<>,.?"
  min_numeric      = 1
  min_upper        = 1
  min_lower        = 1
  min_special      = 1
}

resource "azurerm_windows_virtual_machine" "windows_virtual_machine" {
  count = var.enabled[var.environment] ? 1 : 0

  name                = var.name
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.vm_admin_username
  admin_password      = random_password.random_password.result

  provision_vm_agent = true

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.source_image_publisher
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = var.source_image_version
  }

  network_interface_ids = [
    azurerm_network_interface.nic[0].id,
  ]

  tags = var.tags
}

resource "azurerm_network_interface" "nic" {
  count               = var.enabled[var.environment] ? 1 : 0
  name                = format("nic-vm-%s", var.name)
  resource_group_name = var.rg_name
  location            = var.location

  ip_configuration {
    name                          = "config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_managed_disk" "managed_disk" {
  count                = var.enabled[var.environment] ? 1 : 0
  name                 = format("disk-vm-%s", var.name)
  location             = var.location
  resource_group_name  = var.rg_name
  storage_account_type = var.disk_storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.disk_size
}

resource "azurerm_virtual_machine_data_disk_attachment" "linux_vm_md_attachment" {
  count              = var.enabled[var.environment] ? 1 : 0
  managed_disk_id    = azurerm_managed_disk.managed_disk[0].id
  virtual_machine_id = azurerm_windows_virtual_machine.windows_virtual_machine[0].id
  lun                = "10"
  caching            = "ReadWrite"
}

resource "azurerm_key_vault_secret" "secret_username" {
  count        = var.enabled[var.environment] ? 1 : 0
  name         = format("%s-user", var.name)
  value        = var.vm_admin_username
  key_vault_id = var.keyvault_id
}

resource "azurerm_key_vault_secret" "secret_pass" {
  count        = var.enabled[var.environment] ? 1 : 0
  name         = format("%s-pass", var.name)
  value        = random_password.random_password.result
  key_vault_id = var.keyvault_id
}