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

variable "iot_name" {
  type        = string
  description = "The name of IOT hub."
}

variable "iot_sku_name" {
  type        = string
  description = "The name of the sku. Possible values are B1, B2, B3, F1, S1, S2, and S3"
}

variable "iot_sku_capacity" {
  type        = string
  description = "The number of provisioned IoT Hub units"
}
