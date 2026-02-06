variable "location" {
  type        = string
  description = "The name of the location."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags that will be added to resource"
}

variable "vn_address_space" {
  type        = list(string)
  description = "IP address space of VNET"
}

variable "dns_servers" {
  type        = list(string)
  description = "DNS servers of VNET"
}

variable "main_name" {
  type        = string
  description = "The short name of product or service that could identify this landscape"
}

variable "environment" {
  type        = string
  description = "Short name of environment: p, d, t, a, g"
}
