resource "azurerm_log_analytics_workspace" "logs_workspace" {
  name                = format("law-%s-%s-01", var.environment, var.name)
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = var.la_ws_sku
  retention_in_days   = var.retention_in_days

  tags = var.tags
}

resource "azurerm_log_analytics_solution" "solution_logs" {
  count                 = length(var.solutions)
  solution_name         = var.solutions[count.index].solution_name
  location              = var.location
  resource_group_name   = var.rg_name
  workspace_resource_id = azurerm_log_analytics_workspace.logs_workspace.id
  workspace_name        = azurerm_log_analytics_workspace.logs_workspace.name

  plan {
    publisher = var.solutions[count.index].publisher
    product   = var.solutions[count.index].product
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic" {
  count                      = length(var.diagnostic)
  name                       = var.diagnostic[count.index].diagnostic_name
  target_resource_id         = var.diagnostic[count.index].diagnostic_target_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logs_workspace.id

  dynamic "metric" {
    for_each = var.diagnostic[count.index].diagnostic_metric_name != null ? toset(var.diagnostic[count.index].diagnostic_metric_name) : []

    content {
      category = metric.value

      retention_policy {
        enabled = false
      }
    }
  }

  dynamic "log" {
    for_each = var.diagnostic[count.index].diagnostic_log_name != null ? toset(var.diagnostic[count.index].diagnostic_log_name) : []

    content {
      category = log.value

      retention_policy {
        enabled = false
      }
    }
  }

  lifecycle {
    ignore_changes = [
      log, log_analytics_destination_type
    ]
  }
}