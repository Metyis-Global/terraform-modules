# Introduction 
This is terraform module that create storage account for container instance.

# Usage
```hcl

module "storage_account_pondcloud" {
  providers = {
    azurerm = azurerm
  }
  source                           = "./modules/storage-account"
  storage_account_name             = format("dls%seruvaka03", var.environment)
  storage_account_tier             = "Standard"
  storage_account_replication_type = "GRS"
  storage_account_kind             = "StorageV2"
  network_rules_bypass             = ["AzureServices"]
  storage_account_is_hns_enabled   = true
  tags                             = var.tags
}


```

# Reference information
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account 
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container 
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group 