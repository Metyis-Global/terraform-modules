data "azurerm_key_vault_secret" "root_public_ssh_key" {
  count = var.enabled[var.environment] ? 1 : 0

  name         = var.root_ssh_key_secret_name
  key_vault_id = var.root_ssh_key_key_vault_id
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count = var.enabled[var.environment] ? 1 : 0


  name                = format("vm-%s-%s", var.environment, var.vm_name)
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.vm_admin_username

  provision_vm_agent = true

  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = data.azurerm_key_vault_secret.root_public_ssh_key[0].value
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
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

  custom_data = var.custom_data
  tags        = var.tags
}

resource "azurerm_network_interface" "nic" {
  count = var.enabled[var.environment] ? 1 : 0

  name                = format("nic-vm-%s-%s", var.environment, var.vm_name)
  resource_group_name = var.rg_name
  location            = var.location

  ip_configuration {
    name                          = "config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_managed_disk" "managed_disk" {
  count = var.enabled[var.environment] ? 1 : 0

  name                 = format("disk-vm-%s-%s", var.environment, var.vm_name)
  location             = var.location
  resource_group_name  = var.rg_name
  storage_account_type = var.disk_storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.disk_size
}

resource "azurerm_virtual_machine_data_disk_attachment" "linux_vm_md_attachment" {
  count = var.enabled[var.environment] ? 1 : 0

  managed_disk_id    = azurerm_managed_disk.managed_disk[0].id
  virtual_machine_id = azurerm_linux_virtual_machine.linux_vm[0].id
  lun                = "10"
  caching            = "ReadWrite"
}