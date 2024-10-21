# Overview
This module create key vault and manage access to its objects via access policies instead of IAM roles

# Access policies

```hcl
[
  {
    object_id = "", 
    key_permissions = [],
    secret_permissions = [],
    storage_permissions=[]
  },
]
```

# Reference
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault
https://learn.microsoft.com/en-us/azure/key-vault/general/security-features