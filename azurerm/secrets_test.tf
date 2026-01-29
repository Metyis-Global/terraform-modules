module "secrets_test" {
  source = "./modules/secrets"

  providers = {
    azurerm = azurerm.core
  }

  keyvault_id = module.dummy.vault_id
  secrets     = []
  ss_certificates = [
    {
      content_type       = "application/x-pkcs12"
      days_before_expiry = 30
      exportable         = true
      extended_key_usage = ["1.3.6.1.5.5.7.3.1"]
      key_size           = 2048
      key_type           = "RSA"
      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]
      name               = format("test-%s-%s-root-ca", var.environment, "dummy")
      reuse_key          = true
      subject            = "value"
      validity_in_months = 36
    }
  ]

}
