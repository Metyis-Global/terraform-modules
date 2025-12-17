variable "storage_account_name" {
  type        = string
  description = "Specifies the name of the storage account"
}

variable "storage_account_resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "storage_account_location" {
  type        = string
  description = "Specifies the supported Azure location"
}

variable "storage_account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium"
}

variable "storage_access_tier" {
  type        = string
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot"
}

variable "storage_account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS"
}

variable "storage_account_kind" {
  type        = string
  description = "The name of the account kind"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags that will be added to resource"
}

variable "environment" {
  type        = string
  description = "Short name of environment: p, d, t, a, g"
}

variable "default_action" {
  type        = string
  description = "Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow"
}

variable "ip_rules" {
  type        = set(string)
  description = "List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges are not allowed"
}

variable "bypass" {
  type        = set(string)
  description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None."
}

variable "role_assignmnet_scope" {
  type        = string
  description = "The scope at which the Role Assignment applies."
}

variable "principal_id" {
  type        = string
  description = "The ID of the Principal (User, Group or Service Principal) to assign the Role Definition to"
}

variable "azure_roles" {
  type        = list(string)
  default     = []
  description = "Specify the roles that we want to add in role assignment."
}

variable "law_diagnostic_name" {
  type        = string
  description = "Name of Log Analytics that will store the logs"
}

variable "share_quota" {
  type        = number
  default     = 100
  description = "The maximum size of the share, in gigabytes. For Standard storage accounts, this must be 1GB (or higher) and at most 5120 GB (5 TB). For Premium FileStorage storage accounts, this must be greater than 100 GB and at most 102400 GB (100 TB)."
}