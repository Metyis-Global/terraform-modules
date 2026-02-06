resource "azurerm_public_ip" "pip" {
  name                = format("pip-%s", var.natgw_name)
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]
}

resource "azurerm_public_ip_prefix" "pip_prefix" {
  name                = "nat-gateway-publicIPPrefix"
  location            = var.location
  resource_group_name = var.rg_name
  prefix_length       = 30
  zones               = ["1"]
}

resource "azurerm_nat_gateway" "natgw" {
  name                    = var.natgw_name
  location                = var.location
  resource_group_name     = var.rg_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
  tags                    = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "pip_association" {
  nat_gateway_id       = azurerm_nat_gateway.natgw.id
  public_ip_address_id = azurerm_public_ip.pip.id
}

resource "azurerm_nat_gateway_public_ip_prefix_association" "prefix_association" {
  nat_gateway_id      = azurerm_nat_gateway.natgw.id
  public_ip_prefix_id = azurerm_public_ip_prefix.pip_prefix.id
}

resource "azurerm_subnet_nat_gateway_association" "sn_associations" {
  count          = length(var.associated_subnets)
  nat_gateway_id = azurerm_nat_gateway.natgw.id
  subnet_id      = var.associated_subnets[count.index]
}