resource "azurerm_private_dns_zone" "dns_zones" {
  count               = length(var.dns_zones)
  name                = var.dns_zones[count.index].name
  resource_group_name = var.rg_name
  tags                = var.tags
}

#TODO Add network link creation