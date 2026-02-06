output "eventhub_namespace_id" {
  value = azurerm_eventhub_namespace.event_hub_namespace.id
}

output "eventhub_ids_capture" {
  value = azurerm_eventhub.event_hub_with_capture.*.id
}

output "eventhub_ids_without_capture" {
  value = azurerm_eventhub.event_hub_without_capture.*.id
}

