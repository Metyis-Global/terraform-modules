# Introduction 
This is terraform module that create private endpoint for object and set DNS configuration for it

# Usage
```hcl
resource "azurerm_resource_group" "rg" {
  name     = "rg-default-pe"
  location = "uksouth"
}

resource "azurerm_storage_account" "sa" {
  name                     = "examplestorage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

data "azurerm_private_dns_zone" "blob_dns" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "rg-dns"
}

data "azurerm_subnet" "sn" {
  name                 = "sn-a"
  virtual_network_name = "vn-spoke"
  resource_group_name  = "rg-network"
}

module "private_endpoint_example" {
  #using local module to test latest version
  source = "../private-endpoint"

  rg_name              = azurerm_resource_group.rg.name
  pe_name              = "storage-blob"
  subresource_names    = ["blob"]
  endpoint_resource_id = azurerm_storage_account.sa.id
  pe_subnet_id         = data.azurerm_subnet.sn.id


  dns = {
    zone_ids  = [data.azurerm_private_dns_zone.blob_dns.id]
    zone_name = data.azurerm_private_dns_zone.blob_dns.name
  }
}
```

# Reference information
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint
https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview