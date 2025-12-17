# Overview
This module create subnet outside of VNET

# Usage
```hcl
module "subnet" {
  source = "../subnet/"

  virtual_network_name = "vnet"
  resource_group_name = "resource_group"
  subnet_name = "subnet"
  subnet_address_prefixes = ["10.0.0.0/16"]
}
```

# Subnet delegation
See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet#service_delegation

```hcl
object({
  name = object({
    name = string,
    actions = list(string)
  })
})
```

# Reference
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-subnet