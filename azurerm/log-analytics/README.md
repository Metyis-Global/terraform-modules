# Azure Storage account
This module creates log anaytics workspace and assign diagnostic settings to particular objects

## Usage
```hcl
module "log_analytics" {
  source = "./modules/log-analytics"

  name              = "pondcloud"
  location          = var.default_location
  la_ws_sku         = "PerGB2018"
  retention_in_days = 90
  tags              = var.tags
  environment       = var.environment
  rg_name           = format("rg-%s-pondcloud-01", var.environment)
  solutions         = []

  diagnostic = [
    {
      #IoT Hub
      diagnostic_name        = "iotnonlatam-01_diagnostic"
      diagnostic_target_id   = module.iot_hub_nonlatam_01.iot_id
      diagnostic_metric_name = ["AllMetrics"]
      diagnostic_log_name    = ["DeviceTelemetry", "Connections", "C2DCommands", "JobsOperations", "DeviceStreams"]
    },
  ]
}
```

## Arguments
See source documentation


## Source documentation
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace