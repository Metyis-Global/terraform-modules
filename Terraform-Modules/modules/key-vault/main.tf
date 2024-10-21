resource "azurerm_key_vault" "kv" {
  name                        = format("kv-%s-%s", var.environment, var.kv_name)
  resource_group_name         = var.rg_name
  location                    = var.location
  enabled_for_disk_encryption = true
  tenant_id                   = var.kv_tenant_id
  sku_name                    = var.kv_sku_name
  tags                        = var.tags
  purge_protection_enabled    = var.purge_protection_enabled
  #TODO switch to false after PE integration
  public_network_access_enabled = true

  network_acls {
    bypass                     = var.nacls_bypass
    default_action             = var.nacls_default_action
    ip_rules                   = var.nacls_ip_rules
    virtual_network_subnet_ids = var.nacls_subnet_ids
  }
}

resource "azurerm_key_vault_access_policy" "access_policies" {
  count        = length(var.access_policies_list)
  key_vault_id = azurerm_key_vault.kv.id
  object_id    = var.access_policies_list[count.index].object_id
  tenant_id    = var.kv_tenant_id

  key_permissions         = var.access_policies_list[count.index].key_permissions
  secret_permissions      = var.access_policies_list[count.index].secret_permissions
  storage_permissions     = var.access_policies_list[count.index].storage_permissions
  certificate_permissions = var.access_policies_list[count.index].certificate_permissions
  depends_on              = [azurerm_key_vault.kv]
}

resource "azurerm_key_vault_secret" "secrets" {
  count        = length(var.key_vault_secrets)
  name         = var.key_vault_secrets[count.index]
  value        = "change me"
  key_vault_id = azurerm_key_vault.kv.id

  lifecycle {
    ignore_changes = [
      # Ignore changes to secret values, e.g. because an engineer
      # updates these manually
      value,
    ]
  }

  depends_on = [
    azurerm_key_vault.kv
  ]
}

resource "azurerm_monitor_diagnostic_setting" "default_settings" {
  name                       = format("DefaultSettings-kv-%s-%s", var.environment, var.kv_name)
  target_resource_id         = azurerm_key_vault.kv.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "AuditEvent"

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}
