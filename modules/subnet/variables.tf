variable "rg_name" {
  type        = string
  description = "The name of an existing resource group."
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

variable "subnet_name" {
  type        = string
  description = "Name of subnet that will be created"
}

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "The address prefixes list to use for the subnet"
}

variable "enforce_private_link_endpoint_network_policies" {
  description = "Enable or Disable network policies for the private link endpoint on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false"
  default     = false
  type        = bool
}

variable "enforce_private_link_service_network_policies" {
  description = "Enable or Disable network policies for the private link service on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false"
  default     = false
  type        = bool
}

variable "service_endpoints" {
  description = "The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web."
  default     = []
  type        = list(string)
}

variable "delegation" {
  description = "Configuration delegations on subnet, see README for details"
  default     = []
  type = list(object({
    name       = string
    sd_name    = string
    sd_actions = list(string)
  }))
}