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

variable "keyvault_id" {
  type        = string
  description = "ID of keyvault where username and password will be stored"
}

variable "law_id" {
  type        = string
  description = "Log anaytics workspace id"
}

variable "enabled" {
  description = "Manage deployment resource per environment"
  default = {
    d = true
    p = false
    a = false
  }
}
