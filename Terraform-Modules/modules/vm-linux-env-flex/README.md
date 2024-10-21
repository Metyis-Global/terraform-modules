# Overview
This module create Linux virtual machine with private address.
This module allows on which environment vm will be deployed and on which skipped

# Usage
```hcl
module "vm_erp_01" {
  source = "./modules/vm-linux-env-flex"

  enabled                   = {
    d = true
    p = false
    a = false
  }
  vm_name                   = "erp-01"
  vm_size                   = var.vm_erp_01_vm_size[var.environment]
  custom_data               = base64encode(local.vm_custom_data_erp)
  disk_size                 = var.vm_erp_01_disk_size[var.environment]
  disk_storage_account_type = "Standard_LRS"
  environment               = var.environment
  location                  = var.default_location
  rg_name                   = format("rg-%s-pondcloud-01", var.environment)
  root_ssh_key_key_vault_id = module.kv_pondcloud_integration_01.vault_id
  root_ssh_key_secret_name  = "pondlogs-vm-device-api-ssh-public-key"
  source_image_offer        = "0001-com-ubuntu-server-jammy"
  source_image_publisher    = "Canonical"
  source_image_sku          = "22_04-lts-gen2"
  source_image_version      = "latest"

  subnet_id = module.pondcloud_backoffice_vm_subnet_01.subnet_id

  tags = merge(var.tags, local.vm_erp_01_tags)

}

```





# Reference
https://registry.terraform.io/providers/hashicorp/azurerm/2.17.0/docs/resources/linux_virtual_machine