variable "data_factory_name" {
  type        = string
  description = "Specifies the name of the Data Factory"
}

variable "data_factory_location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists"
}

variable "data_factory_resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Data Factory."
}

variable "data_factory_identity_type" {
  type        = string
  description = "Specifies the type of Managed Service Identity that should be configured on this Synapse Workspace. The only possible value is SystemAssigned"
}

variable "tags" {
  type        = map(string)
  description = "Tags for datafactory module"
}

variable "account_name" {
  type        = string
  description = "Specifies the GitHub account name."
}


variable "branch_name" {
  type        = string
  description = "Specifies the branch of the repository to get code from"
}

variable "repository_name" {
  type        = string
  description = "Specifies the name of the git repository."
}

variable "root_folder" {
  type        = string
  description = " Specifies the root folder within the repository. Set to / for the top level."
}

variable "project_name" {
  type        = string
  description = " Specifies the name of the VSTS project."
}

variable "tenant_id" {
  type        = string
  description = "Specifies the Tenant ID associated with the VSTS account"
}

variable "law_diagnostic_name" {
  type        = string
  description = "Name of Log Analytics that will store the logs"
}

variable "environment_ext" {
  type        = string
  description = "Extended name of environment: production, development, test, acceptance, generic"
}

variable "integration_runtime_name" {
  type        = string
  description = "The name of IR."
}

variable "subnet_id" {
  type        = string
  description = "The name subnet where IR will be located"
}

variable "adf_ir_size" {
  type        = string
  default     = "Standard_DS3_v2"
  description = "The size of VM for ADF integration runtime"
}

variable "admin_username" {
  type        = string
  default     = "eruvaka-root"
  description = "The name of administrator of VM"
}

variable "keyvault_id" {
  type        = string
  description = "ID of KV where secrets wull be stored"
}

