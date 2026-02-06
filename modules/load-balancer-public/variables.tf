variable "rg_name" {
  type        = string
  description = "The name of an existing resource group."
}

variable "location" {
  type        = string
  description = "The name of the location."
}

variable "lb_name" {
  type        = string
  description = "The name of the container group of ACI"
}

variable "tags" {
  type        = map(string)
  description = "Tags that will be added to resource"
}

variable "lb_probe_port" {
  type        = number
  description = "The port for probe"
}

variable "be_port" {
  type        = number
  description = "The port for FE"
}

variable "fe_port" {
  type        = number
  description = "The port for BE"
}

variable "vnet_id" {
  type        = string
  description = "ID of VNET"
}

variable "backend_ip" {
  type        = string
  description = "IP of backend target"
}