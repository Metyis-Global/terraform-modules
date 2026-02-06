resource "azurerm_mssql_server" "sql_server" {
  name                = var.sql_server_name
  resource_group_name = var.sql_server_resource_group_name
  location            = var.sql_server_location
  version             = var.sql_server_version
  tags                = var.tags
  azuread_administrator {
    azuread_authentication_only = true
    login_username              = var.sql_server_azuread_admin_username
    object_id                   = var.sql_server_azuread_objectid
  }
}

resource "azurerm_mssql_database" "mssql_database" {
  name                 = var.mssql_database_name
  server_id            = azurerm_mssql_server.sql_server.id
  sku_name             = var.mssql_sku_name
  storage_account_type = var.mssql_storage_account_type
  tags                 = var.tags
  depends_on = [
    azurerm_mssql_server.sql_server
  ]
}

resource "azurerm_mssql_server_transparent_data_encryption" "mssql_server_tde" {
  server_id = azurerm_mssql_server.sql_server.id
  depends_on = [
    azurerm_mssql_server.sql_server
  ]

}