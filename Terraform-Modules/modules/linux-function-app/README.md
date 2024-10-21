# Overview
This module creates function app

# Usage
```hcl
module "func_iot_int_device_get" {
  source = "./modules/linux-function-app"
  
  name   = "iot-int-device-get"
  environment = var.environment
  identity_ids = [azurerm_user_assigned_identity.pondcloudiotint.id]
  identity_type = "UserAssigned"
  location = var.default_location
  log_analytics_workspace_id = module.log_analytics_pondcloud.resource_id
  rg_name = format("rg-%s-pondcloud-01", var.environment)
  function_app_storage_name = module.storage_account_functions_blob.name
  function_app_storage_primary_access_key = module.storage_account_functions_blob.primary_access_key
  tags = merge(var.tags, local.application_insights_infra_tags)
}
}
```





# Reference
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights
