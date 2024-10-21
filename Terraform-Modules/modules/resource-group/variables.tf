# Resource Group Variables

variable "rg_name" {
  description = "The Name of the Resource Group"
  type        = string
}

variable "rg_location" {
  type        = string
  description = "Location of the resource group."
}

variable "rg_tags" {
  type        = map(string)
  description = "Tags that will be added to resource"
}