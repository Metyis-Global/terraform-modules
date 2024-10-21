resource "azurerm_resource_group" "main" {
  name     = format("rg-%s-%s", var.environment, var.main_name)
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = format("vn-%s-%s", var.environment, var.main_name)
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
