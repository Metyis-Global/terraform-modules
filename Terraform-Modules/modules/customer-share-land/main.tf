# Dedicated resource group for data sharing
resource "azurerm_resource_group" "main" {
  name     = format("rg-s-%s", var.customer_share_id)
  location = var.location
  tags     = var.tags
}

# Dedicated network for data sharing
resource "azurerm_virtual_network" "vnet" {
  name                = format("vn-s-%s", var.customer_share_id)
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = var.vn_address_space
  tags                = var.tags
  dns_servers         = var.dns_servers

  lifecycle {
    prevent_destroy = true
  }

  depends_on = [azurerm_resource_group.main]
}

# Dedicated storage for data sharing
resource "azurerm_storage_account" "main" {
  name                     = format("dlssshare%s", var.customer_share_id)
  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.location
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = true
  tags                     = var.tags

  network_rules {
    default_action = "Allow"
    ip_rules       = var.ip_rules
    bypass         = ["AzureServices"]
  }
}

resource "azurerm_role_assignment" "role_assignmnet" {
  scope                = azurerm_storage_account.main.id
  role_definition_name = "Owner"
  principal_id         = var.principal_id
}

resource "azurerm_storage_container" "storage_container_data" {
  name                  = "data"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "storage_container_metadata" {
  name                  = "metadata"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "storage_container_billing" {
  name                  = "billing"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

resource "azurerm_monitor_diagnostic_setting" "default_settings_storage" {
  name                       = format("DefaultSettingsStorage-dlsshare%s", var.customer_share_id)
  target_resource_id         = azurerm_storage_account.main.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  metric {
    category = "AllMetrics"
    retention_policy {
      enabled = false
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "default_settings_blob" {
  name                       = format("DefaultSettingsBlob-dlssshare%s", var.customer_share_id)
  target_resource_id         = format("%s/blobServices/default", azurerm_storage_account.main.id)
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

resource "azurerm_eventhub_namespace" "event_hub_namespace" {
  name                = format("evhns-s-%s", var.customer_share_id)
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = var.event_hub_namespace_sku
  capacity            = var.event_hub_namespace_capacity

  auto_inflate_enabled     = true
  maximum_throughput_units = var.event_hub_namespace_maximum_throughput_units

  tags = var.tags
}

resource "azurerm_eventhub" "event_hub_with_capture" {

  name                = "events"
  namespace_name      = azurerm_eventhub_namespace.event_hub_namespace.name
  resource_group_name = azurerm_resource_group.main.name
  partition_count     = var.event_hubs_partition_count
  message_retention   = "3"

  capture_description {
    enabled             = true
    encoding            = "Avro"
    interval_in_seconds = "600"
    size_limit_in_bytes = "136314880"
    skip_empty_archives = true
    destination {
      name                = "EventHubArchive.AzureBlockBlob"
      archive_name_format = "{Namespace}/{EventHub}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}/{PartitionId}"
      blob_container_name = azurerm_storage_container.storage_container_data.name
      storage_account_id  = azurerm_storage_account.main.id
    }
  }

  depends_on = [azurerm_eventhub_namespace.event_hub_namespace]
}

resource "azurerm_eventhub_consumer_group" "consumer_group_with_capture" {

  name                = format("cg-s-%s", var.customer_share_id)
  namespace_name      = azurerm_eventhub_namespace.event_hub_namespace.name
  eventhub_name       = azurerm_eventhub.event_hub_with_capture.name
  resource_group_name = azurerm_resource_group.main.name

  depends_on = [azurerm_eventhub.event_hub_with_capture]
}

resource "azurerm_monitor_diagnostic_setting" "default_settings_event_hub" {
  name                       = format("DefaultSettingsEventHub-%s", var.customer_share_id)
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
