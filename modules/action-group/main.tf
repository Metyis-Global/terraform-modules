resource "azurerm_monitor_action_group" "action_group" {
  name                = var.action_group_name
  resource_group_name = var.rg_name
  short_name          = var.short_name
  for_each            = { for idx, email in var.email_list : idx => email }

  email_receiver {
    name                    = each.value.name
    email_address           = each.value.email_address
    use_common_alert_schema = var.use_common_alert_schema
  }
}