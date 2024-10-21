# Overview
This module creates container app environment

# Usage
```hcl
module "aca_env_backend_01" {
  source = "./modules/container-app-environment"

  aca_env_name               = format("aca-%s-pondcloud-backend-01", var.environment)
  environment                = var.environment
  location                   = var.default_location
  log_analytics_workspace_id = module.log_analytics_pondcloud.resource_id
  rg_name                    = format("rg-%s-pondcloud-01", var.environment)
  subnet_id                  = module.pondcloud_cont_apps_subnet_01.subnet_id
  tags = merge(var.tags, local.cont_apps_backend_tags)

  depends_on = [
    module.pondcloud_cont_apps_subnet_01]
}
```





# Reference
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment
