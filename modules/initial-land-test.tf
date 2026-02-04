module "test_initial_land" {
  source = "./initial-land"

  providers {
    azurerm = azurerm
  }

  dns_servers      = []
  environment      = "g"
  main_name        = "test-01"
  vn_address_space = ["10.0.0.0/16"]
}