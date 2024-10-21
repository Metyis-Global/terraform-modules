variable "name" {
  description = "Name of Log Analystics Workspace."
}

variable "rg_name" {
  description = "Name of resource group to deploy resources in."
}

variable "location" {
  description = "Azure location where resources should be deployed."
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "version_server" {
  description = "Azure Postgresql server version to be deployed."
}

variable "login_name" {
  description = "Login id for Azure Postgresql server."
}

variable "storage_size" {
  description = "Storage size for Azure Postgresql server."
}

variable "postgresql_type" {
  description = "Azure Postgresql server type."
}

variable "db_name" {
  description = "Azure Postgresql database name."
}

variable "keyvault_id" {
  description = "Keyvalud details for Azure Postgresql."
}

