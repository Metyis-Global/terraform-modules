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
  description = "Tags that will be added to resource"
}

variable "environment" {
  type        = string
  description = "Short name of environment: p, d, t, a, g"
}

variable "pe_name" {
  type        = string
  description = "Name of private endpoint without env prefix and pe prefix"
}

variable "subnet_id" {
  type        = string
  description = "Id of subnet where private endpoint will be placed"
}

variable "private_service_connection_resource_id" {
  type        = string
  description = "The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to"
}

variable "private_service_connection_subresource_names" {
  description = "A list of subresource names which the Private Endpoint is able to connect to."
}

variable "dns_zone_ids" {
  type        = string
  description = "Specifies the list of Private DNS Zones to include"
}

variable "dns_zone_name" {
  type        = string
  description = "Specifies the Name of the Private DNS Zone Group"
}