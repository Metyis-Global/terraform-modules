resource "azurerm_private_endpoint" "main" {
  tags                = var.tags
  name                = format("pe-%s-%s", var.environment, var.pe_name)
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = format("conn-%s-%s", var.environment, var.pe_name)
    private_connection_resource_id = var.private_service_connection_resource_id
    subresource_names              = var.private_service_connection_subresource_names
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = var.dns_zone_name
    private_dns_zone_ids = var.dns_zone_ids
  }
}