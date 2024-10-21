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

variable "application_insights_name" {
  type        = string
  description = "The name of an application insights"
}

variable "application_type" {
  type        = string
  description = "The type of an application insights"
}

variable "disable_ip_masking" {
  type        = bool
  default     = false
  description = "By default the real client IP is masked as 0.0.0.0 in the logs. Use this argument to disable masking and log the real client IP"
}
