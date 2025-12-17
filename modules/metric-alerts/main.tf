resource "azurerm_monitor_metric_alert" "metric_alert" {
  name                = var.metric_alert_name
  resource_group_name = var.rg_name
  scopes              = var.scopes
  description         = var.description

  criteria {
    metric_namespace = var.metric_namespace
    metric_name      = var.metric_name
    aggregation      = var.aggregation
    operator         = var.operator
    threshold        = var.threshold

  }

  /*action {
    action_group_id = azurerm_monitor_action_group.action_group.id
      }*/
}
