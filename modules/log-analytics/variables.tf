variable "name" {
  description = "Name of Log Analystics Workspace."
}

variable "rg_name" {
  description = "Name of resource group to deploy resources in."
}

variable "location" {
  description = "Azure location where resources should be deployed."
}

variable "la_ws_sku" {
  description = "Specified the Sku of the Log Analytics Workspace."
}

variable "retention_in_days" {
  description = "The workspace data retention in days. Possible values range between 30 and 730."
  default     = 30
}

variable "solutions" {
  description = "A list of solutions to add to the workspace. Should contain solution_name, publisher and product."
  type        = list(object({ solution_name = string, publisher = string, product = string }))
  default     = []
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "environment" {
  type        = string
  description = "Short name of environment: p, d, t, a, g"
}

variable "diagnostic" {
  type        = list(object({ diagnostic_name = string, diagnostic_target_id = string, diagnostic_metric_name = list(string), diagnostic_log_name = list(string) }))
  description = "List of Diagnostic services: Name, Target ID, Metrics Name"
}