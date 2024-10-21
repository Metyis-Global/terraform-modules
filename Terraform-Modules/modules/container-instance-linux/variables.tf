variable "rg_name" {
  type        = string
  description = "The name of an existing resource group."
}

variable "location" {
  type        = string
  description = "The name of the location."
}

variable "cg_name" {
  type        = string
  description = "The name of the container group of ACI"
}

variable "tags" {
  type        = map(string)
  description = "Tags that will be added to resource"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnets where containers will be located"
}

variable "environment" {
  type        = string
  description = "Short name of environment"
}

variable "enabled" {
  description = "Manage deployment resource per environment"
  default = {
    d = true
    p = false
    a = false
  }
}

variable "containers" {
  description = "List of containers that will be running in the container group"
  type        = map(any)
}

variable "exposed_ports" {
  description = "It can only contain ports that are also exposed on one or more containers in the group"
  type = list(object({
    port     = number
    protocol = string
  }))

  default = [{
    port     = 8080
    protocol = "TCP"
  }]
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace id to be used with container logs"
  type        = string
}

variable "log_analytics_workspace_key" {
  description = "Log Analytics workspace  access key to be used with container logs"
  type        = string
}

variable "image_registry_credential_password" {
  description = "PAssword for ACR"
  type        = string
}

variable "image_registry_credential_server" {
  description = "ACR URL"
  type        = string
}

variable "image_registry_credential_username" {
  description = "ACR username"
  type        = string
}
