output "iot_id" {
  value       = azurerm_iothub.iothub.id
  description = "The ID of the IoTHub"
}

output "iot_event_hub_events_endpoint" {
  value       = azurerm_iothub.iothub.event_hub_events_endpoint
  description = "The EventHub compatible endpoint for events data"
}

output "iot_event_hub_events_namespace" {
  value       = azurerm_iothub.iothub.event_hub_events_namespace
  description = "The EventHub namespace for events data"
}

output "iot_event_hub_events_path" {
  value       = azurerm_iothub.iothub.event_hub_events_path
  description = "The EventHub compatible path for events data"
}

output "iot_event_hub_operations_endpoint" {
  value       = azurerm_iothub.iothub.event_hub_operations_endpoint
  description = "The EventHub compatible endpoint for operational data"
}

output "iot_event_hub_operations_path" {
  value       = azurerm_iothub.iothub.event_hub_events_path
  description = "The EventHub compatible path for operational data"
}