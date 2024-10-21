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

variable "vn_name" {
  type        = string
  description = "Name of VNET"
}

variable "nsg_name" {
  type        = string
  description = "The name of an network security group."
}

variable "nsg_rules" {
  type        = list(any)
  description = "Network security group rules"
  default     = []
}

variable "nsg_associations" {
  type        = list(map(string))
  description = "Network security group association to subnets"
}
