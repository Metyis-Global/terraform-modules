# Azure Fabric Capacity Module
#
# This module deploys and manages a Microsoft Fabric capacity in Azure.

resource "azapi_resource" "fab_capacity" {

  # type = "Microsoft.Fabric/capacities@2022-07-01-preview"
  type = "Microsoft.Fabric/capacities@2023-11-01"

  # name                      = format("fab%s%s", var.environment, var.fab_name)
  name                      = var.fab_name
  parent_id                 = var.resource_group_id
  location                  = var.location
  schema_validation_enabled = false

  body = jsonencode({
    properties = {
      administration = {
        members = var.fab_admin_emails
      }
    }
    sku = {
      name = var.sku,
      tier = "Fabric"
    }
  })

  tags = var.tags

  count = var.module_enabled ? 1 : 0

}