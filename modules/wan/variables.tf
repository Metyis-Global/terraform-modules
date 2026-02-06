variable "location" {
  type        = string
  description = "The name of the location."
}

variable "rg_name" {
  type        = string
  description = "The name of resource group"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags that will be added to resource"
}

variable "environment" {
  type        = string
  description = "Short name of environment: p, d, t, a, g"
}

variable "name" {
  type        = string
  description = "Postfix of hub and wan names"
}

variable "hub_address_prefix" {
  type        = string
  description = "IP address prefix for virtual hub"
}

variable "vnet_connections" {
  type = list(object(
    {
      name = string
      id   = string
    }
  ))
  description = "Names and IDs of VNETs that will be connected to hub"
}