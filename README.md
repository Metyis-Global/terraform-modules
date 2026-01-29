---
 
# Terraform Modules (Metyis)

Central catalog of Terraform modules used across Metyis projects for building Azure workloads with a common baseline (naming, tags, networking, security). Modules are consumable from this repository and are kept aligned with HashiCorp best practices and the AzureRM provider.

## Repository Layout

- `modules/` — one folder per Azure building block (networking, security, compute, data, app, observability, shared services). Each module contains `main.tf`, `variables.tf`, and `outputs.tf`.
- `modules/_providers.tf` — provider and backend template; modules expect the AzureRM provider `~> 3.65.0`.
- `modules/infra-modules-terraform.yml` — Azure DevOps pipeline to publish the modules as an artifact (optional; used in our internal pipelines).
- Example skeletons such as `modules/initial-land-test.tf` and `modules/secrets_test.tf` show how to compose modules.

## Using the Modules in Metyis Projects

1) Add backend and provider (configure your own Azure Storage account/container for state):

```hcl
terraform {
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.65.0"
    }
  }
}

provider "azurerm" {
  features {}
}
```

2) Consume modules directly from GitHub. Pin to a tag/commit to avoid drift (example uses `main`):

```hcl
module "rg" {
  source      = "git::https://github.com/Metyis-Global/terraform-modules.git//modules/resource-group?ref=main"
  rg_name     = "rg-metyis-demo-dev"
  rg_location = "westeurope"
  rg_tags     = {
    environment = "dev"
    owner       = "cloud-ops"
  }
}
```

3) Compose additional modules for the stack (for example VNet, subnets, private endpoints, key vault, storage, compute, data, and observability components) from the `modules/` directory.

## Contributing

- Follow a GitOps flow: create a feature branch from `main`, add your module or changes, and open a pull request.
- Include a `README.md` and a minimal working example with every new/updated module.
- Run `terraform fmt` and `terraform validate` for your changes; prefer tagging releases and pinning consumers to tags.

## Support

Reach out to the Metyis Cloud Ops team for questions, reviews, or onboarding help.
