variable "rg_name" {
  description = "Name of resource group to deploy resources in."
}

variable "location" {
  description = "Azure location where resources should be deployed."
}

variable "environment" {
  type        = string
  description = "Short name of environment"
}

variable "tags" {
  type        = map(string)
  description = "Tags that will be added to resource"
}

variable "sig_name" {
  type        = string
  description = "Name of Shared Image Gallery"
}


variable "hyper_v_generation" {
  type        = string
  default     = "V2"
  description = "Name of Shared Image Gallery"
}

/* variable "si_name" {
  type        = string
  description = "Name of Shared Image"
}/*  

variable "publisher_name" {
  type        = string
  description = "Name of Publisher"
}

variable "offer_name" {
  type        = string
  description = "Name of offer by publisher"
}

variable "sku_vm" {
  type        = string
  description = "Name of sku by publisher"
}

variable "os_type" {
  type        = string
  description = "VM OS Family Linux/Windows"
} */

variable "gallery_description" {
  type        = string
  description = "OS image"
}

variable "si" {
  type = list(
    object(
      {
        name           = string
        os_type        = string
        publisher_name = string
        offer_name     = string
        sku_vm         = string

      }
  ))
  description = "Specifies image creation for single workload"
}