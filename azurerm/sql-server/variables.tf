# SQL server variables
variable "sql_server_name" {
  type        = string
  description = "The name of the Microsoft SQL Server."
}

variable "sql_server_resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Microsoft SQL Server."

}

variable "sql_server_location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists"
}

variable "sql_server_azuread_admin_username" {
  type        = string
  description = " The administrator email for the new server"

}

variable "sql_server_azuread_objectid" {
  type        = string
  description = "ObjectID of The administrator for the new server"

}

variable "sql_server_version" {
  type        = string
  description = "The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)."
}

# SQl Database variables 

variable "mssql_database_name" {
  type        = string
  description = "The name of the MS SQL Database."
}

variable "mssql_sku_name" {
  type        = string
  description = "The name of the SKU used on the DB"
}

variable "mssql_storage_account_type" {
  type        = string
  description = "The type of Redundancy"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags that will be added to resource"
}

