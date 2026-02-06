# Overview
This module create network security group and assigns it to defined subnets



# Network rule definition
```hcl
rules = [
  {
  name                        = "test123",
  priority                    = 100,
  direction                   = "Outbound",
  access                      = "Allow",
  protocol                    = "Tcp",
  source_port_range           = "*",
  destination_port_range      = "*",
  source_address_prefix       = "*",
  destination_address_prefix  = "*",
  }
]
```

# Reference
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group