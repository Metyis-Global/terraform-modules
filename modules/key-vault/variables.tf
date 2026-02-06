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
  default     = {}
  description = "Tags that will be added to resource"
}

variable "environment" {
  type        = string
  description = "Short name of environment"
}

variable "kv_name" {
  type        = string
  description = "Name of key vault"
}

variable "kv_tenant_id" {
  type        = string
  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault."
}

variable "kv_sku_name" {
  type        = string
  description = "The Name of the SKU used for this Key Vault"
}

variable "nacls_bypass" {
  type        = string
  description = "Specifies which traffic can bypass the network rules: AzureServices or None"
}

variable "nacls_default_action" {
  type        = string
  description = "The Default Action to use when no rules match"
}

variable "nacls_ip_rules" {
  type        = list(string)
  description = "One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault."
}

variable "nacls_subnet_ids" {
  type        = list(string)
  description = "One or more Subnet IDs which should be able to access this Key Vault"
}

variable "access_policies_list" {
  type = list(
    object(
      {
        object_id               = string
        key_permissions         = list(string)
        secret_permissions      = list(string)
        storage_permissions     = list(string)
        certificate_permissions = list(string)
      }
    )
  )
  description = "List of access policies for key vault"
}

variable "key_vault_secrets" {
  type        = list(string)
  description = "List of secret names for key vault"
}

variable "purge_protection_enabled" {
  type        = bool
  default     = true
  description = "Specifies purge protection policy for key vault"
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