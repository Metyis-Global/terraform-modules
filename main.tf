resource "azurerm_container_registry" "acr" {
  name                = format("acr%s%s", var.environment, var.name)
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = true
  tags                = var.tags
}

resource "azurerm_role_assignment" "acr_pull" {
  count                            = length(var.access_list)
  principal_id                     = var.access_list[count.index]
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "acr_push" {
  count                            = length(var.access_list)
  principal_id                     = var.access_list[count.index]
  role_definition_name             = "AcrPush"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "acr_delete" {
  count                            = length(var.access_list)
  principal_id                     = var.access_list[count.index]
  role_definition_name             = "AcrDelete"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}
