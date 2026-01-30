# Resource Group

resource "azurerm_resource_group" "resource_group" {

  # name     = format("rg-%s-%s", var.environment, var.rg_name)
  name     = var.rg_name
  location = var.rg_location
  tags     = var.rg_tags

}