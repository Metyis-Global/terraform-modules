output "iothub_dps_id" {
  value       = azurerm_iothub_dps.device_provisioning_service.id
  description = "The ID of the IoTHub DPS"
}

output "iothub_dps_host_name" {
  value       = azurerm_iothub_dps.device_provisioning_service.device_provisioning_host_name
  description = "The device endpoint of the IoT Device Provisioning Service."
}

output "iothub_dps_id_scope" {
  value       = azurerm_iothub_dps.device_provisioning_service.id_scope
  description = "The unique identifier of the IoT Device Provisioning Service."
}

output "iothub_dps_service_operations_host_name" {
  value       = azurerm_iothub_dps.device_provisioning_service.service_operations_host_name
  description = "The service endpoint of the IoT Device Provisioning Service."
}
