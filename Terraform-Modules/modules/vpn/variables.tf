variable "location" {
  type        = string
  description = "The name of the location."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags that will be added to resource"
}

variable "rg_name" {
  type        = string
  description = "The name of resource group"
}

variable "environment" {
  type        = string
  description = "Short name of environment: p, d, t, a, g"
}

variable "scale_unit" {
  type        = number
  default     = 1
  description = "Scale unit of VPN server"
}

variable "vpn_client_address_pool_prefixes" {
  type        = list(string)
  description = "A list of CIDR Ranges which should be used as Address Prefixes for VPN clients"
}

variable "vpn_postfix_name" {
  type        = string
  description = "The postfix of VPN objects"
}

variable "virtual_hub_id" {
  type        = string
  description = "The id of virtual hub where virtual gateway will be placed"
}

variable "key_vault_id" {
  type        = string
  description = "ID of key vault where certificate will be stored for VPN GW"
}
