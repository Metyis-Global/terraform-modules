resource "azurerm_key_vault_certificate" "vpn_gw_root_cert" {
  name         = format("vpngw-%s-%s-root-ca", var.environment, var.vpn_postfix_name)
  key_vault_id = var.key_vault_id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = 30
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      extended_key_usage = ["1.3.6.1.5.5.7.3.1"]

      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

      subject            = format("CN=Eruvaka VPN Gateway vpngw-%s-%s", var.environment, var.vpn_postfix_name)
      validity_in_months = 36
    }
  }
}

data "azurerm_key_vault_certificate_data" "vpn_gw_root_cert" {
  name         = format("vpngw-%s-%s-root-ca", var.environment, var.vpn_postfix_name)
  key_vault_id = var.key_vault_id

  depends_on = [azurerm_key_vault_certificate.vpn_gw_root_cert]
}

resource "azurerm_vpn_server_configuration" "main" {
  name                     = format("vpngwconf-%s-%s", var.environment, var.vpn_postfix_name)
  resource_group_name      = var.rg_name
  location                 = var.location
  vpn_authentication_types = ["Certificate"]

  client_root_certificate {
    name             = format("vpngw-%s-%s-root-ca", var.environment, var.vpn_postfix_name)
    public_cert_data = azurerm_key_vault_certificate.vpn_gw_root_cert.certificate_data_base64
  }

  depends_on = [azurerm_key_vault_certificate.vpn_gw_root_cert]
}

resource "azurerm_point_to_site_vpn_gateway" "main" {
  name                        = format("vpngw-%s-%s", var.environment, var.vpn_postfix_name)
  location                    = var.location
  resource_group_name         = var.rg_name
  virtual_hub_id              = var.virtual_hub_id
  vpn_server_configuration_id = azurerm_vpn_server_configuration.main.id
  scale_unit                  = var.scale_unit
  connection_configuration {
    name = format("vgwcc-%s", var.vpn_gateway_name)

    vpn_client_address_pool {
      address_prefixes = var.vpn_client_address_pool_prefixes
    }
  }

  depends_on = [azurerm_vpn_server_configuration.main]
}