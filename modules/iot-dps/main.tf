resource "azurerm_iothub_dps" "device_provisioning_service" {
  name                = var.dps_name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_policy   = var.dps_allocation_policy

  # TODO monitor when terraform will support different tiers of DPS
  sku {
    # only S1 is supported at this moment
    name     = "S1"
    capacity = var.dps_sku_capacity
  }

  public_network_access_enabled = var.dps_public_network_access
  tags                          = var.tags

  lifecycle {
    ignore_changes = [
      linked_hub
    ]
  }
}