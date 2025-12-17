resource "azurerm_service_plan" "main" {
  name                = format("appsp-%s-pondcloud-%s", var.environment, var.name)
  resource_group_name = var.rg_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.service_plan_sku
  tags                = var.tags
}

resource "azurerm_linux_function_app" "function_app" {
  name                = format("func-%s-pondcloud-%s", var.environment, var.name)
  resource_group_name = var.rg_name
  location            = var.location

  storage_account_name          = var.function_app_storage_name
  storage_account_access_key    = var.function_app_storage_primary_access_key
  service_plan_id               = azurerm_service_plan.main.id
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  site_config {
    application_stack {
      python_version = "3.11"
    }
  }
}