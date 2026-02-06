resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = var.storage_account_resource_group_name
  location                 = var.storage_account_location
  account_tier             = var.storage_account_tier
  access_tier              = var.storage_access_tier
  account_replication_type = var.storage_account_replication_type
  account_kind             = var.storage_account_kind
  tags                     = var.tags

  network_rules {
    default_action = var.default_action
    ip_rules       = var.ip_rules
    bypass         = var.bypass
  }
}

resource "azurerm_role_assignment" "role_assignmnet" {
  count                = length(var.azure_roles)
  scope                = var.role_assignmnet_scope
  role_definition_name = var.azure_roles[count.index]
  principal_id         = var.principal_id
}

data "azurerm_storage_account" "sta_details" {
  name                = var.storage_account_name
  resource_group_name = var.storage_account_resource_group_name
  depends_on          = [azurerm_storage_account.main]
}

resource "azurerm_storage_share" "main" {
  name                 = "share"
  storage_account_name = azurerm_storage_account.main.name
  quota                = var.share_quota
}