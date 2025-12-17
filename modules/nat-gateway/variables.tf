variable "name" {
  description = "Name of Log Analystics Workspace."
}

variable "rg_name" {
  description = "Name of resource group to deploy resources in."
}

variable "location" {
  description = "Azure location where resources should be deployed."
}

variable "natgw_name" {
  description = "Name of NAT gateway"
}

variable "tags" {
  type        = map(string)
  description = "Tags that will be added to resource"
}

variable "associated_subnets" {
  type        = list(string)
  description = "Specify the IDs of subnets that will be associated"
  default     = []
}
