resource "azurerm_public_ip" "lb_pip" {
  name                = format("pip-%s", var.lb_name)
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "lb-pip"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend_address_pool" {
  name            = "lb-backend"
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_lb_probe" "lb_probe" {
  name            = "tcp-probe"
  protocol        = "Tcp"
  port            = var.lb_probe_port
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_lb_rule" "lb_rule_app" {
  name                           = "lb-rule-app"
  protocol                       = "Tcp"
  frontend_port                  = var.fe_port
  backend_port                   = var.be_port
  frontend_ip_configuration_name = azurerm_lb.lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_backend_address_pool.id]
  probe_id                       = azurerm_lb_probe.lb_probe.id
  loadbalancer_id                = azurerm_lb.lb.id
}

resource "azurerm_lb_backend_address_pool_address" "lb_be_adress" {
  name                    = "be-address"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_address_pool.id
  ip_address              = var.backend_ip
  virtual_network_id      = var.vnet_id
}