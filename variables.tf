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
  description = "Short name of environment"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "ID of log analytics workspace"
}

variable "name" {
  type        = string
  description = "Name of linux function app"
}

variable "service_plan_sku" {
  type        = string
  default     = "Y1"
  description = "SKU of service plan"
}

variable "public_network_access_enabled" {
  type        = bool
  default     = true
  description = "Should public network access be enabled for the Function App"
}

# TODO add VNET integration
# variable "virtual_network_subnet_id" {
#   type        = string
#   description = "The subnet id which will be used by this Function App"
# }

variable "identity_type" {
  type        = string
  description = "The Assigned Identity type"
}

variable "identity_ids" {
  type        = list(string)
  description = "The User Assigned Identity IDs"
}

variable "function_app_storage_name" {
  type        = string
  description = "Storage account used by function app"
}

variable "function_app_storage_primary_access_key" {
  type        = string
  description = "Access key for storage account used by function app"
}