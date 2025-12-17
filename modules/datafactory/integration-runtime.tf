## See bug for terraform and ADF IR https://github.com/hashicorp/terraform-provider-azurerm/issues/15012
#
#resource "random_password" "password" {
#  length = 24
#  special = true
#  override_special = "_%@"
#}
#
#resource "azurerm_key_vault_secret" "adf_ir_vm_password" {
#
#  name         = format("vm-adf-ir-%s-password",var.data_factory_name)
#  value        = random_password.password.result
#  key_vault_id = var.keyvault_id
#
#  depends_on = [random_password.password]
#}
#
#resource "azurerm_key_vault_secret" "adf_ir_vm_admin_username" {
#
#  name         = format("vm-adf-ir-%s-admin-username",var.data_factory_name)
#  value        = var.admin_username
#  key_vault_id = var.keyvault_id
#
#  depends_on = [random_password.password]
#}
#
#resource "azurerm_public_ip" "public_ip" {
#  name                = format("pip-%s",var.data_factory_name)
#  location            = var.data_factory_location
#  resource_group_name = var.data_factory_resource_group_name
#  allocation_method   = "Static"
#  sku                 = "Standard"
#}
#
#resource "azurerm_network_interface" "adf_ir_nic" {
#  name                = format("nic-%s",var.data_factory_name)
#  location            = var.data_factory_location
#  resource_group_name = var.data_factory_resource_group_name
#
#  ip_configuration {
#    name                          = "config"
#    subnet_id                     = var.subnet_id
#    private_ip_address_allocation = "Dynamic"
#    public_ip_address_id          = azurerm_public_ip.public_ip.id
#  }
#
#  depends_on = [azurerm_public_ip.public_ip]
#}
#
#resource "azurerm_windows_virtual_machine" "adf_ir_vm" {
#  name                = var.integration_runtime_name
#  location            = var.data_factory_location
#  resource_group_name = var.data_factory_resource_group_name
#  size                = var.adf_ir_size
#
#  network_interface_ids = [azurerm_network_interface.adf_ir_nic.id]
#
#  admin_username = var.admin_username
#  admin_password = random_password.password.result
#
#  os_disk {
#    caching              = "ReadWrite"
#    storage_account_type = "Standard_LRS"
#  }
#
#  source_image_reference {
#    publisher = "MicrosoftWindowsServer"
#    offer     = "WindowsServer"
#    sku       = "2019-Datacenter"
#    version   = "latest"
#  }
#
#  depends_on = [random_password.password,azurerm_network_interface.adf_ir_nic]
#}
#
#
#
