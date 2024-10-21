# Modules that use providers outside Hashicorps library require explicit specification.
terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "1.7.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.65.0"
    }
  }
}

provider "databricks" {
  host                        = azurerm_databricks_workspace.databricks.workspace_url
  azure_workspace_resource_id = azurerm_databricks_workspace.databricks.id
  azure_client_id             = var.dbr_sp_appid
  azure_client_secret         = var.dbr_sp_password
  azure_tenant_id             = var.dbr_sp_tenantid
}