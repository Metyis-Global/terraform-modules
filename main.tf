resource "azurerm_container_app_environment" "acae" {
  name                           = var.aca_env_name
  location                       = var.location
  resource_group_name            = var.rg_name
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  infrastructure_subnet_id       = var.subnet_id
  internal_load_balancer_enabled = true
}