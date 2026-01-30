# Azure Automation Account Module
#
# This module deploys and manages a Azure Automation Account in Azure.

# https://github.com/equinor/terraform-azurerm-automation/blob/main/main.tf
# locals {
#   # If system_assigned_identity_enabled is true, value is "SystemAssigned".
#   # If identity_ids is non-empty, value is "UserAssigned".
#   # If system_assigned_identity_enabled is true and identity_ids is non-empty, value is "SystemAssigned, UserAssigned".
#   identity_type = join(", ", compact([var.system_assigned_identity_enabled ? "SystemAssigned" : "", length(var.identity_ids) > 0 ? "UserAssigned" : ""]))

#   #   diagnostic_setting_metric_categories = ["AllMetrics"]
# }

# https://github.com/sironite/terraform-azurerm-automation_account

resource "azurerm_automation_account" "automation_account" {
  name                = var.aut_account_name
  resource_group_name = var.rg_name
  location            = var.default_location
  sku_name            = var.sku_name

  local_authentication_enabled  = var.local_authentication_enabled
  public_network_access_enabled = var.public_network_access_enabled

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  tags = var.tags

}