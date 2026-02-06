variable "dns_zones" {
  type        = list(map(string))
  description = "(Required) Specifies the DNS Zones where the resource exists. Changing this forces a new resource to be created."
}

variable "rg_name" {
  type        = string
  description = "(Required) Specifies the resource group where the DNS Zone (parent resource) exists. Changing this forces a new resource to be created."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the created DNS zone."
  default     = {}
}
