resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.storage_account_resource_group_name
  location                 = var.storage_account_location
  account_tier             = var.storage_account_tier
  access_tier              = var.storage_access_tier
  account_replication_type = var.storage_account_replication_type
  account_kind             = var.storage_account_kind
  is_hns_enabled           = var.storage_account_is_hns_enabled
  tags                     = var.tags

  network_rules {
    default_action = var.default_action
    ip_rules       = var.ip_rules
    bypass         = var.bypass
  }
}

resource "azurerm_storage_container" "storage_container" {
  count                 = length(var.storage_containers)
  name                  = var.storage_containers[count.index]
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
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
  depends_on          = [azurerm_storage_account.storage_account]
}

resource "azurerm_monitor_diagnostic_setting" "default_settings" {
  name                       = format("DefaultSettingsStorage-%s", var.storage_account_name)
  target_resource_id         = azurerm_storage_account.storage_account.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  metric {
    category = "Capacity"

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "Transaction"

    retention_policy {
      enabled = false
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "default_settings_blob" {
  name                       = format("DefaultSettingsBlob-%s", var.storage_account_name)
  target_resource_id         = format("%s/blobServices/default", azurerm_storage_account.storage_account.id)
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "StorageRead"

    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "StorageWrite"


    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "StorageDelete"


    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "Capacity"

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "Transaction"

    retention_policy {
      enabled = false
    }
  }
}
