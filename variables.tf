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

variable "root_ssh_key_secret_name" {
  type        = string
  description = "The name of secret in KV where public SSH key is stored"
}

variable "root_ssh_key_key_vault_id" {
  type        = string
  description = "The ID of key vault where ssh key is stored"
}

variable "environment" {
  type        = string
  description = "Short name of environment"
}

variable "vm_name" {
  type        = string
  description = "The name of VM"
}

variable "vm_size" {
  type        = string
  description = "The size of VM"
}

variable "vm_admin_username" {
  type        = string
  default     = "eruvaka-root"
  description = "The username of admin"
}

variable "custom_data" {
  type        = string
  description = "base64encoded custom data: base64encode(string)"
}

variable "source_image_publisher" {
  type        = string
  description = "Publisher of image for VM"
}

variable "source_image_offer" {
  type        = string
  description = "Offer of image for VM"
}

variable "source_image_sku" {
  type        = string
  description = "SKU of image for VM"
}

variable "source_image_version" {
  type        = string
  description = "Version of image for VM"
}

variable "subnet_id" {
  type        = string
  description = "ID of subnet where VM will be located"
}

variable "disk_storage_account_type" {
  type        = string
  description = "The type of storage to use for the managed disk. Possible values are Standard_LRS, StandardSSD_ZRS, Premium_LRS, PremiumV2_LRS, Premium_ZRS, StandardSSD_LRS or UltraSSD_LRS"
}

variable "disk_size" {
  type        = number
  description = "Size of managed disk"
}

# variable "include_identity" {
#   default     = false
#   description = "Exclude creation managed identity"
# }

# variable "identity_type" {
#   default     = "SystemAssigned"
#   description = "System Assigned Managed Identity Parameter  SystemAssigned, UserAssigned, SystemAssigned,UserAssigned (both)"
# }

# variable "identitytype" {
#   type        = string
#   description = "System Assigned Managed Identity Parameter  SystemAssigned, UserAssigned, SystemAssigned,UserAssigned (both)"
# }

# variable "identity_ids" {
#   type        = string
#   description = "System Assigned Managed Identity Parameter"
# }