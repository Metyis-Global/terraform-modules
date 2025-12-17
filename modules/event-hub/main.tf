resource "azurerm_eventhub_namespace" "event_hub_namespace" {
  name                 = format("evhns-%s", var.event_hub_namespace_name)
  location             = var.location
  resource_group_name  = var.rg_name
  sku                  = var.event_hub_namespace_sku
  capacity             = var.event_hub_namespace_capacity
  auto_inflate_enabled = false

  lifecycle {
    ignore_changes = [auto_inflate_enabled]
  }

  tags = var.tags
}

resource "azurerm_eventhub" "event_hub_with_capture" {
  count = length(var.event_hubs_with_capture)

  name                = var.event_hubs_with_capture[count.index].eventhub_name
  namespace_name      = azurerm_eventhub_namespace.event_hub_namespace.name
  resource_group_name = var.rg_name
  partition_count     = var.event_hubs_with_capture[count.index].partition_count
  message_retention   = var.event_hubs_with_capture[count.index].message_retention

  capture_description {
    enabled             = true
    encoding            = var.event_hubs_with_capture[count.index].encoding
    interval_in_seconds = var.event_hubs_with_capture[count.index].interval_in_seconds
    size_limit_in_bytes = var.event_hubs_with_capture[count.index].size_limit_in_bytes
    skip_empty_archives = var.event_hubs_with_capture[count.index].skip_empty_archives
    destination {
      name                = "EventHubArchive.AzureBlockBlob"
      archive_name_format = var.event_hubs_with_capture[count.index].archive_name_format
      blob_container_name = var.event_hubs_with_capture[count.index].blob_container_name
      storage_account_id  = var.event_hubs_with_capture[count.index].storage_account_id
    }
  }

  depends_on = [azurerm_eventhub_namespace.event_hub_namespace]
}

resource "azurerm_eventhub" "event_hub_without_capture" {
  count = length(var.event_hubs_without_capture)

  name                = var.event_hubs_without_capture[count.index].eventhub_name
  namespace_name      = azurerm_eventhub_namespace.event_hub_namespace.name
  resource_group_name = var.rg_name
  partition_count     = var.event_hubs_without_capture[count.index].partition_count
  message_retention   = var.event_hubs_without_capture[count.index].message_retention

  depends_on = [azurerm_eventhub_namespace.event_hub_namespace]
}

resource "azurerm_eventhub_consumer_group" "consumer_group_without_capture" {
  count = length(var.event_hubs_without_capture)

  name                = format("cg-%s", var.event_hubs_without_capture[count.index].eventhub_name)
  namespace_name      = azurerm_eventhub_namespace.event_hub_namespace.name
  eventhub_name       = var.event_hubs_without_capture[count.index].eventhub_name
  resource_group_name = var.rg_name

  depends_on = [azurerm_eventhub.event_hub_without_capture]
}

resource "azurerm_eventhub_consumer_group" "consumer_group_with_capture" {
  count = length(var.event_hubs_with_capture)

  name                = format("cg-%s", var.event_hubs_with_capture[count.index].eventhub_name)
  namespace_name      = azurerm_eventhub_namespace.event_hub_namespace.name
  eventhub_name       = var.event_hubs_with_capture[count.index].eventhub_name
  resource_group_name = var.rg_name

  depends_on = [azurerm_eventhub.event_hub_with_capture]
}

resource "azurerm_eventhub_authorization_rule" "auth_rule_send_listen_without_capture" {
  count = length(var.event_hubs_without_capture)

  name                = format("send-list-%s", var.event_hubs_without_capture[count.index].eventhub_name)
  namespace_name      = azurerm_eventhub_namespace.event_hub_namespace.name
  eventhub_name       = var.event_hubs_without_capture[count.index].eventhub_name
  resource_group_name = var.rg_name
  listen              = true
  send                = true
  manage              = false

  depends_on = [azurerm_eventhub.event_hub_without_capture]
}

resource "azurerm_eventhub_authorization_rule" "auth_rule_all_without_capture" {
  count = length(var.event_hubs_without_capture)

  name                = format("manage-%s", var.event_hubs_without_capture[count.index].eventhub_name)
  namespace_name      = azurerm_eventhub_namespace.event_hub_namespace.name
  eventhub_name       = var.event_hubs_without_capture[count.index].eventhub_name
  resource_group_name = var.rg_name
  listen              = true
  send                = true
  manage              = true

  depends_on = [azurerm_eventhub.event_hub_without_capture]
}

resource "azurerm_eventhub_authorization_rule" "auth_rule_send_listen_with_capture" {
  count = length(var.event_hubs_with_capture)

  name                = format("send-list-%s", var.event_hubs_with_capture[count.index].eventhub_name)
  namespace_name      = azurerm_eventhub_namespace.event_hub_namespace.name
  eventhub_name       = var.event_hubs_with_capture[count.index].eventhub_name
  resource_group_name = var.rg_name
  listen              = true
  send                = true
  manage              = false

  depends_on = [azurerm_eventhub.event_hub_with_capture]
}

resource "azurerm_eventhub_authorization_rule" "auth_rule_all_with_capture" {
  count = length(var.event_hubs_with_capture)

  name                = format("manage-%s", var.event_hubs_with_capture[count.index].eventhub_name)
  namespace_name      = azurerm_eventhub_namespace.event_hub_namespace.name
  eventhub_name       = var.event_hubs_with_capture[count.index].eventhub_name
  resource_group_name = var.rg_name
  listen              = true
  send                = true
  manage              = true

  depends_on = [azurerm_eventhub.event_hub_with_capture]
}

resource "azurerm_key_vault_secret" "eventhub_secrets_without_capture_all" {
  count = length(azurerm_eventhub_authorization_rule.auth_rule_all_without_capture[*].primary_connection_string)

  name         = format("%s-%s-pcs-own", azurerm_eventhub_namespace.event_hub_namespace.name, azurerm_eventhub_authorization_rule.auth_rule_all_without_capture[count.index].eventhub_name)
  value        = azurerm_eventhub_authorization_rule.auth_rule_all_without_capture[count.index].primary_connection_string
  key_vault_id = var.keyvault_id

  depends_on = [azurerm_eventhub_authorization_rule.auth_rule_all_without_capture]
}

resource "azurerm_key_vault_secret" "eventhub_secrets_with_capture_all" {
  count = length(azurerm_eventhub_authorization_rule.auth_rule_all_with_capture[*].primary_connection_string)

  name         = format("%s-%s-pcs-own", azurerm_eventhub_namespace.event_hub_namespace.name, azurerm_eventhub_authorization_rule.auth_rule_all_with_capture[count.index].eventhub_name)
  value        = azurerm_eventhub_authorization_rule.auth_rule_all_with_capture[count.index].primary_connection_string
  key_vault_id = var.keyvault_id

  depends_on = [azurerm_eventhub_authorization_rule.auth_rule_all_with_capture]
}

resource "azurerm_key_vault_secret" "eventhub_secrets_without_capture_send_listen" {
  count = length(azurerm_eventhub_authorization_rule.auth_rule_send_listen_without_capture[*].primary_connection_string)

  name         = format("%s-%s-pcs-seli", azurerm_eventhub_namespace.event_hub_namespace.name, azurerm_eventhub_authorization_rule.auth_rule_send_listen_without_capture[count.index].eventhub_name)
  value        = azurerm_eventhub_authorization_rule.auth_rule_send_listen_without_capture[count.index].primary_connection_string
  key_vault_id = var.keyvault_id

  depends_on = [azurerm_eventhub_authorization_rule.auth_rule_send_listen_without_capture]
}

resource "azurerm_key_vault_secret" "eventhub_secrets_with_capture_send_listen" {
  count = length(azurerm_eventhub_authorization_rule.auth_rule_send_listen_with_capture[*].primary_connection_string)

  name         = format("%s-%s-pcs-seli", azurerm_eventhub_namespace.event_hub_namespace.name, azurerm_eventhub_authorization_rule.auth_rule_send_listen_with_capture[count.index].eventhub_name)
  value        = azurerm_eventhub_authorization_rule.auth_rule_send_listen_with_capture[count.index].primary_connection_string
  key_vault_id = var.keyvault_id

  depends_on = [azurerm_eventhub_authorization_rule.auth_rule_send_listen_with_capture]
}

resource "azurerm_monitor_diagnostic_setting" "default_settings" {
  name                       = format("DefaultSettingsEventHub-%s", var.event_hub_namespace_name)
  target_resource_id         = azurerm_eventhub_namespace.event_hub_namespace.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "ArchiveLogs"


    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "OperationalLogs"


    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "AutoScaleLogs"


    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "KafkaCoordinatorLogs"


    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "KafkaUserErrorLogs"


    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "EventHubVNetConnectionEvent"


    retention_policy {
      enabled = false
    }
  }


  enabled_log {
    category = "RuntimeAuditLogs"


    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "ApplicationMetricsLogs"


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

resource "azurerm_eventhub_namespace_authorization_rule" "evhns_auth_rule" {
  name                = format("send-list-%s", var.event_hub_namespace_name)
  namespace_name      = format("evhns-%s", var.event_hub_namespace_name)
  resource_group_name = var.rg_name

  listen     = true
  send       = true
  manage     = false
  depends_on = [azurerm_eventhub_namespace.event_hub_namespace]
}

resource "azurerm_key_vault_secret" "event_hub_namespace_secrets_send_listen" {
  name         = format("%s-pcs-seli", azurerm_eventhub_namespace.event_hub_namespace.name)
  value        = azurerm_eventhub_namespace_authorization_rule.evhns_auth_rule.primary_connection_string
  key_vault_id = var.keyvault_id

  depends_on = [azurerm_eventhub_namespace_authorization_rule.evhns_auth_rule]
}