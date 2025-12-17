variable "event_hub_namespace_name" {
  type        = string
  description = "Specifies the name of the EventHub Namespace resource."
}

variable "event_hub_namespace_sku" {
  type        = string
  description = "Defines which tier to use. Valid options are Basic, Standard, and Premium."
}

variable "event_hub_namespace_capacity" {
  type        = string
  description = "Specifies the Capacity / Throughput Units for a Standard SKU namespace."
}

variable "rg_name" {
  type        = string
  description = "The name of an existing resource group."
}

variable "location" {
  type        = string
  description = "The name of the location."
}

variable "keyvault_id" {
  type        = string
  description = "The ID of key vault where all secrets will be shared."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags that will be added to resource"
}

variable "event_hubs_with_capture" {
  type = list(
    object(
      {
        eventhub_name       = string
        resource_group_name = string
        partition_count     = number
        message_retention   = number
        encoding            = string
        interval_in_seconds = number
        size_limit_in_bytes = number
        skip_empty_archives = bool
        blob_container_name = string
        storage_account_id  = string
        archive_name_format = string
      }
  ))
  description = "Specifies event hubs that must be created with capture enabled"
}

variable "event_hubs_without_capture" {
  type = list(
    object(
      {
        eventhub_name       = string
        resource_group_name = string
        partition_count     = number
        message_retention   = number
      }
  ))
  description = "Specifies event hubs that must be created with capture enabled"
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace id to be used with container logs"
  type        = string
}

variable "log_analytics_workspace_key" {
  description = "Log Analytics workspace  access key to be used with container logs"
  default     = ""
  type        = string
}