resource "azurerm_data_factory" "data_factory" {
  name                = var.data_factory_name
  location            = var.data_factory_location
  resource_group_name = var.data_factory_resource_group_name
  tags                = var.tags
  identity {
    type = var.data_factory_identity_type
  }

  vsts_configuration {
    account_name    = var.account_name
    branch_name     = var.branch_name
    project_name    = var.project_name
    repository_name = var.repository_name
    root_folder     = var.root_folder
    tenant_id       = var.tenant_id
  }

  lifecycle {
    ignore_changes = [
      global_parameter
    ]
  }
}

data "azurerm_log_analytics_workspace" "law_details" {
  name                = var.law_diagnostic_name
  resource_group_name = var.data_factory_resource_group_name
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic" {
  name                       = format("%s_diagnostic", var.data_factory_name)
  target_resource_id         = azurerm_data_factory.data_factory.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law_details.id

  log {
    category = "ActivityRuns"
    enabled  = true

    retention_policy {
      days    = 90
      enabled = false
    }
  }

  log {
    category = "PipelineRuns"
    enabled  = true

    retention_policy {
      days    = 90
      enabled = false
    }
  }

  log {
    category = "TriggerRuns"
    enabled  = true

    retention_policy {
      days    = 90
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      days    = 90
      enabled = false
    }
  }

  lifecycle {
    ignore_changes = [
      log, log_analytics_destination_type
    ]
  }
}
