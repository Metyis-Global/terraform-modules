# Introduction 
This is terraform module that creates sql server and database.

# Usage
```hcl
resource "azurerm_resource_group" "rg" {
  name     = "rg-default-pe"
  location = "uksouth"
}

resource "azurerm_mssql_database" {

  source                           = "./infra-modules/sql-server"
  mssql_database_name        = ""  
  mssql_server_id            = ""
  mssql_sku_name             = "Local"
  mssql_storage_account_type = "Basic"
}

resource "azurerm_mssql_server {
  source                           = "./infra-modules/sql-server"
  rg_name                          = azurerm_resource_group.rg.name
  sql_server_name                   = var.sql_server_name
  sql_server_location               = var.sql_server_location
  sql_server_azuread_admin_username = var.sql_server_azuread_admin_username
  sql_server_azuread_objectid       = "15328b8d-dd8f-45e0-b868-32974525daf1"
  sql_server_version                = "12.0"
 
}

```

# Reference information
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database

azurerm_mssql_firewall_rule | Resources | hashicorp/azurerm | Terraform Registry
azurerm_mssql_server_extended_auditing_policy | Resources | hashicorp/azurerm | Terraform Registry
azurerm_mssql_server_transparent_data_encryption | Resources | hashicorp/azurerm | Terraform Registry