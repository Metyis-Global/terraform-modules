# Standard
variable "rg_name" {
  type        = string
  description = "The name of the resource group in which to create the databrciks resource."
}
variable "tags" {
  type        = map(string)
  description = "Tags for the resources"
}
variable "environment" {
  type        = string
  description = "Short name of environment: p, d, t, a, g"
}



# sp-dta-pondcloud-data-integration
variable "dbr_sp_appid" {
  type        = string
  description = "appid for Eruvaka service principal"
}

variable "dbr_sp_tenantid" {
  type        = string
  description = "tenantid for Eruvaka service principal"
}

variable "dbr_sp_password" {
  type        = string
  description = "password for Eruvaka service principal"
}

# Databricks Workspace (AzureRM)
variable "dbw_name" {
  type        = string
  description = "Specifies the name of the Databricks Workspace resource. Changing this forces a new resource to be created."
}
variable "dbw_location" {
  type        = string
  description = "Specifies the supported Azure location where the resource has to be created. Changing this forces a new resource to be created."
}
variable "dbw_sku" {
  type        = string
  description = "The sku to use for the Databricks Workspace. Possible values are standard, premium, or trial. Changing this can force a new resource to be created in some circumstances."
}

variable "dbw_public_network_access_enabled" {
  type        = bool
  description = "Allow public access for accessing workspace. Set value to false to access workspace only via private link endpoint. Possible values include true or false. Defaults to true. Changing this forc"
}


# Databricks Cluster (Databricks)
variable "dbc_configs" {
  type = list(object({
    dbc_cluster_name            = string
    dbv_gpu                     = bool
    dbv_ml                      = bool
    dbv_lts                     = bool
    dbv_latest                  = bool
    dbv_driver_node_type_id     = string
    dbv_node_type               = string
    dbc_autotermination_minutes = number
    dbc_min_workers             = number
    dbc_max_worker              = number
    dbc_custom_tags             = map(string)
    dbc_spark_conf              = map(any)
    dbc_spark_env_vars          = map(any)
    dbc_elastic_disk            = bool
    dbc_data_sec_mode           = string
    dbc_spark_runtime_engine    = string
  }))
  description = " Databricks Cluster configurations"
}


# Custom Parameters
variable "dbw_vnet_id" {
  type        = string
  description = "Virtual Network ID that Databricks will use"
}

variable "dbw_public_subnet_name" {
  type        = string
  description = "Public Subnet name that Databricks will use"
}

variable "dbw_private_subnet_name" {
  type        = string
  description = "Private Subnet name that Databricks will use"
}

variable "dbw_private_subnet_id" {
  type        = string
  description = "Private Subnet ID that Databricks will use"
}

variable "dbw_public_subnet_id" {
  type        = string
  description = "Public Subnet name that Databricks will use"
}

#Libraries

variable "maven_coordinates_eventhub" {
  type = string
}

variable "maven_coordinates_deequ" {
  type = string
}

variable "pypi_library1" {
  type = string
}

variable "pypi_library2" {
  type = string
}

variable "pypi_library3" {
  type = string
}

variable "pypi_library4" {
  type = string
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace id to be used with container logs"
  type        = string
}