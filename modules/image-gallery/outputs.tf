output "shared_image_names_list" {
  description = "Azure Shared Images output object"
  value       = azurerm_shared_image.si.*.name
}

output "shared_image_gallery_name" {
  description = "Azure Shared Image Gallery name"
  value       = azurerm_shared_image_gallery.sig.name
}
