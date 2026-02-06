variable "customer_share_id" {
  type        = string
  description = "Specifies the name used in every object"
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags that will be added to resource"
}

variable "ip_rules" {
  type        = set(string)
  description = "List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges are not allowed"
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

variable "vn_address_space" {
  type        = list(string)
  description = "IP address space of VNET"
}

variable "dns_servers" {
  type        = list(string)
  description = "DNS servers of VNET"
}

variable "event_hub_namespace_sku" {
  description = "EH SKU"
  default     = "Standard"
  type        = string
}

variable "event_hub_namespace_capacity" {
  description = "EH capacity"
  default     = "1"
  type        = string
}

variable "event_hub_namespace_maximum_throughput_units" {
  description = "Maximum number of throughput units in EH"
  default     = "1"
  type        = string
}

variable "event_hubs_partition_count" {
  description = "Count of partitions in EH"
  default     = "1"
  type        = string
}

variable "principal_id" {
  description = "Principal id for storage accout access"
  default     = "6e9830a9-e0ff-4ece-a3e7-6baeaa305683"
  type        = string
}