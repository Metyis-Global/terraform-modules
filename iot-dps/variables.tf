variable "rg_name" {
  type        = string
  description = "The name of an existing resource group."
}

variable "location" {
  type        = string
  description = "The name of the location."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags that will be added to resource"
}

variable "dps_name" {
  type        = string
  description = "Specifies the name of the Iot Device Provisioning Service resource"
}

variable "dps_allocation_policy" {
  type        = string
  description = "The allocation policy of the IoT Device Provisioning Service (Hashed, GeoLatency or Static)"
  default     = "Hashed"
}

variable "dps_sku_capacity" {
  type        = number
  description = "The number of provisioned IoT Device Provisioning Service units"
  default     = 1
}

variable "dps_public_network_access" {
  type        = bool
  description = "Whether requests from Public Network are allowed"
}

variable "linked_hub_allocation_policy" {
  type        = bool
  description = "Determines whether to apply allocation policies to the IoT Hub"
  default     = true
}

variable "linked_hub_allocation_weight" {
  type        = number
  description = "The weight applied to the IoT Hub"
  default     = 0
}
