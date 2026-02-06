resource "azurerm_key_vault_secret" "secrets" {
  count        = length(var.secrets)
  name         = var.secrets[count.index]
  value        = "change_me"
  key_vault_id = var.keyvault_id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "azurerm_key_vault_certificate" "ss_certificates" {
  count        = length(var.ss_certificates_params)
  name         = var.ss_certificates_params[count.index].name
  key_vault_id = var.keyvault_id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = var.ss_certificates_params[count.index].exportable
      key_size   = var.ss_certificates_params[count.index].key_size
      key_type   = var.ss_certificates_params[count.index].key_type
      reuse_key  = var.ss_certificates_params[count.index].reuse_key
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = var.ss_certificates_params[count.index].days_before_expiry
      }
    }

    secret_properties {
      content_type = var.ss_certificates_params[count.index].content_type
    }

    x509_certificate_properties {
      extended_key_usage = var.ss_certificates_params[count.index].extended_key_usage

      key_usage = var.ss_certificates_params[count.index].key_usage

      subject            = format("CN=%s", var.ss_certificates_params[count.index].subject)
      validity_in_months = var.ss_certificates_params[count.index].validity_in_months
    }
  }
}
