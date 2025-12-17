#Random password generation
resource "random_password" "random_password" {
  length           = 24
  special          = true
  override_special = "~!@#$%^&*_-+=|(){}[]:;<>,.?"
  min_numeric      = 1
  min_upper        = 1
  min_lower        = 1
  min_special      = 1
}

#Postgresql server creation
resource "azurerm_postgresql_flexible_server" "postgresql" {
  name                   = var.name
  resource_group_name    = var.rg_name
  location               = var.location
  version                = var.version_server
  administrator_login    = var.login_name
  administrator_password = random_password.random_password.result
  zone                   = "1"

  tags       = var.tags
  storage_mb = var.storage_size

  sku_name = var.postgresql_type
}

#Postgresql database creation
resource "azurerm_postgresql_flexible_server_database" "postgresql_db" {
  name      = var.db_name
  server_id = azurerm_postgresql_flexible_server.postgresql.id
  collation = "en_US.utf8"
  charset   = "utf8"
}

resource "azurerm_key_vault_secret" "secret_username" {
  name         = format("%s-user", var.name)
  value        = var.login_name
  key_vault_id = var.keyvault_id
}

resource "azurerm_key_vault_secret" "secret_pass" {
  name         = format("%s-pass", var.name)
  value        = random_password.random_password.result
  key_vault_id = var.keyvault_id
}