resource "azurerm_subnet" "snet" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vn_name
  address_prefixes     = var.subnet_address_prefixes

  dynamic "delegation" {
    for_each = var.delegation == null ? [] : var.delegation
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.sd_name
        actions = delegation.value.sd_actions
      }
    }
  }


  enforce_private_link_endpoint_network_policies = var.enforce_private_link_endpoint_network_policies
  enforce_private_link_service_network_policies  = var.enforce_private_link_service_network_policies
  service_endpoints                              = var.service_endpoints
}