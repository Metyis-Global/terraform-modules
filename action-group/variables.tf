variable "action_group_name" {
  type        = string
  description = "The name of the Action Group"
}

variable "short_name" {
  type        = string
  description = "The short name of the action group. This will be used in SMS messages"
}

variable "rg_name" {
  type        = string
  description = "The name of an existing resource group."
}

#variable "name" {
#  type        = string
#  description = "The name of the email receiver. Names must be unique (case-insensitive) across all receivers within an action group"
#}

variable "email_list" {
  description = "List of email receivers with name and email address"
  type = list(object({
    name          = string
    email_address = string
  }))
  default = [
    {
      name          = "eruvaka_admin"
      email_address = "sanjeev.basineni@eruvaka.com"
    },
    {
      name          = "sendtoadmin"
      email_address = "nikita.rogatov@metyis.com"
    },
    {
      name          = "sendtoadmins"
      email_address = "ambika.chamarajeurs@adaptfy.com"
    },
    {
      name          = "sendtoadmin"
      email_address = "sri.kodali@eruvaka.com"
    },
    {
      name          = "sendtoadmins"
      email_address = "carlo.sacchi@adaptfy.com"
    },

    # Add more receivers as needed
  ]
}


variable "use_common_alert_schema" {
  type        = string
  description = "Enables or disables the common alert schema"
}
