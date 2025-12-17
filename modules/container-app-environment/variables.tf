variable "rg_name" {
  type        = string
  description = "The name of an existing resource group."
}

variable "location" {
  type        = string
  description = "The name of the location."
}

variable "aca_env_name" {
  type        = string
  description = "The name of ACA environment"
}

variable "subnet_id" {
  type        = string
  description = "The existing Subnet to use for the Container Apps Control Plane. Changing this forces a new resource to be created"
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