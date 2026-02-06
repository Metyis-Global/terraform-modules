resource "azurerm_virtual_wan" "wan" {
  name                = format("wan-%s-%s", var.environment, var.name)
  resource_group_name = var.rg_name
  location            = var.location
}

resource "azurerm_virtual_hub" "hub" {
  name                = format("vh-%s-%s", var.environment, var.name)
  resource_group_name = var.rg_name
  location            = var.location
  virtual_wan_id      = azurerm_virtual_wan.wan.id
  address_prefix      = var.hub_address_prefix

  depends_on = [azurerm_virtual_wan.wan]
}


resource "azurerm_virtual_hub_connection" "connection" {
  count                     = length(var.vnet_connections)
  name                      = format("vhc-%s", var.vnet_connections[count.index].name)
  virtual_hub_id            = azurerm_virtual_hub.hub.id
  remote_virtual_network_id = var.vnet_connections[count.index].id

  depends_on = [azurerm_virtual_hub.hub]
}