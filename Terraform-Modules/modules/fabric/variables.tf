variable "fab_name" {
  type        = string
  description = "Fabric Capacity Name"
}

variable "resource_group_id" {
  type        = string
  description = "Resource group id."
}

variable "location" {
  type        = string
  description = "Location of the resource group."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags which should be assigned to the deployed resource."
}

variable "module_enabled" {
  type        = bool
  description = "Variable to enable or disable the module."
  default     = true
}

variable "sku" {
  type        = string
  description = "SKU name"
}

variable "environment" {
  type        = string
  description = "Short name of environment"
}

variable "fab_admin_emails" {
  type        = list(string)
  description = "Fabric administrator email"
}

variable "system_assigned_identity_enabled" {
  description = "Should the system-assigned identity be enabled for this Web App?"
  type        = bool
  default     = true
}

variable "identity_ids" {
  description = "A list of IDs of managed identities to be assigned to this Web App."
  type        = list(string)
  default     = []
}
