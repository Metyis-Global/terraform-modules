# Overview
This module create resource group and VNET without! subnets. Use dedicated subnet module to create subnets if its needed

# Usage
```hcl
module "initial_land" {
  source = "./initial-land"

  providers {
    azurerm = azurerm.myazuresubscr
  }

  dns_servers      = []
  environment      = "g"
  main_name        = "test-01"
  vn_address_space = ["10.0.0.0/16"]
}
```

# Reference
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network