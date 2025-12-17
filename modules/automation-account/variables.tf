variable "aut_account_name" {
  description = "The name of Automation Account."
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
}

variable "default_location" {
  description = "The location to create the resources in."
  type        = string
}

variable "sku_name" {
  description = "The SKU name of this Automation account."
  type        = string
  default     = "Basic"
}

variable "local_authentication_enabled" {
  description = "Should local authentication be enabled for this Automation account?"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Should public network access be enabled for this Automation account?"
  type        = bool
  default     = true
}

variable "system_assigned_identity_enabled" {
  description = "Should the system-assigned identity be enabled for this Web App?"
  type        = bool
  default     = false
}

variable "identity_type" {
  type        = string
  description = "The type of identity to assign to the Azure Automation Account."
  default     = "SystemAssigned"
}

variable "identity_ids" {
  type        = list(string)
  description = "The list of identity IDs to assign to the Azure Automation Account."
  default     = []
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}