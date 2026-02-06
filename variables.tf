variable "keyvault_id" {
  type        = string
  description = "ID of key vault"
}

variable "secrets" {
  default     = []
  type        = list(string)
  description = "List of names of secrets that will be added to key vault, values must be defined manually in UI"
}

variable "ss_certificates_params" {
  default = []
  type = list(
    object(
      {
        name               = string,
        exportable         = bool,
        key_size           = number,
        key_type           = string,
        reuse_key          = bool,
        days_before_expiry = number,
        content_type       = string,
        extended_key_usage = list(string),
        key_usage          = list(string),
        subject            = string,
        validity_in_months = number,
      }
    )
  )
  description = "List of params for generation of self signed certificate"
}
