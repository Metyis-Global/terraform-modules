resource "azurerm_application_insights" "main" {
  name                = format("appins-%s-%s", var.environment, var.application_insights_name)
  location            = var.location
  resource_group_name = var.rg_name
  workspace_id        = var.log_analytics_workspace_id
  application_type    = var.application_type
  disable_ip_masking  = var.disable_ip_masking
  tags                = var.tags
}

