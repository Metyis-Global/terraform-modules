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
  description = "Tags that will be added to resource"
}

variable "environment" {
  type        = string
  description = "Short name of environment"
}

variable "name" {
  type        = string
  description = "The name of ACR"
}

variable "access_list" {
  type        = list(string)
  description = "List of group or user IDs who has access to PUSH PULL operations"
}
