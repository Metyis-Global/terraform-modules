resource "azurerm_shared_image_gallery" "sig" {
  name                = format("sig%s%s", var.environment, var.sig_name)
  resource_group_name = var.rg_name
  location            = var.location
  description         = var.gallery_description
  tags                = var.tags
}

resource "azurerm_shared_image" "si" {
  count               = length(var.si)
  name                = format("asi-%s-%s", var.environment, var.si[count.index].name)
  gallery_name        = azurerm_shared_image_gallery.sig.name
  resource_group_name = var.rg_name
  location            = var.location
  tags                = var.tags
  os_type             = var.si[count.index].os_type
  hyper_v_generation  = var.hyper_v_generation

  identifier {
    publisher = var.si[count.index].publisher_name
    offer     = var.si[count.index].offer_name
    sku       = var.si[count.index].sku_vm
  }
}