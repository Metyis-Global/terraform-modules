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


variable "vm_admin_username" {
  type        = string
  default     = "eruvaka"
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

variable "lb_sku" {
  type        = string
  default     = "Standard"
  description = "SKU of internal load balancer"
}

variable "vm_sku" {
  type        = string
  description = "SKU of VM in scale set"
}

variable "instances" {
  type        = number
  default     = 1
  description = "Initial count of instances"
}

variable "instances_min" {
  type        = number
  default     = 1
  description = "Min count of instances"
}

variable "instances_max" {
  type        = number
  default     = 5
  description = "Max count of instances"
}

variable "data_disk_size" {
  type        = number
  description = "Size of data disk"
}

variable "autoscale_cpu_thresold_increase" {
  type        = number
  default     = 75
  description = "%CPU utilization when new instance will be created"
}

variable "autoscale_cpu_thresold_decrease" {
  type        = number
  default     = 25
  description = "%CPU utilization when instance will be destroyed"
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace id to be used with container logs"
  type        = string
}

variable "log_analytics_workspace_key" {
  description = "Log Analytics workspace  access key to be used with container logs"
  type        = string
}

#variable "extensions" {
#  description = "Extensions to add to the Scale Set."
#  type        = list(any)
#}

#variable "user_assigned_ids" {
# description = "Extensions to add to the Scale Set."
#  type        = list(any)
#}

variable "application_gateway_backend_address_pool_ids" {
  description = "List of backend address pool ids for application gateway"
  type        = list(any)
}
