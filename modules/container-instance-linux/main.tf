resource "azurerm_container_group" "main" {
  count = var.enabled[var.environment] ? 1 : 0

  name                = var.cg_name
  location            = var.location
  resource_group_name = var.rg_name
  os_type             = "Linux"
  ip_address_type     = "Private"
  subnet_ids          = var.subnet_ids

  restart_policy = "Always"

  dynamic "exposed_port" {
    for_each = var.exposed_ports
    content {
      port     = exposed_port.value.port
      protocol = exposed_port.value.protocol
    }
  }

  dynamic "container" {
    for_each = var.containers
    content {
      name   = container.key
      image  = container.value.image
      cpu    = container.value.cpu
      memory = container.value.memory

      dynamic "ports" {
        for_each = container.value.ports
        content {
          port     = ports.value.port
          protocol = ports.value.protocol
        }
      }

      dynamic "volume" {
        for_each = container.value.volumes
        content {
          mount_path           = volume.value.mount_path
          name                 = volume.key
          read_only            = volume.value.read_only
          storage_account_name = volume.value.storage_account_name
          storage_account_key  = volume.value.storage_account_key
          share_name           = volume.value.share_name
        }
      }

      environment_variables = container.value.environment_variables
    }
  }

  image_registry_credential {

    password = var.image_registry_credential_password
    server   = var.image_registry_credential_server
    username = var.image_registry_credential_username

  }

  diagnostics {
    log_analytics {
      workspace_id  = var.log_analytics_workspace_id
      workspace_key = var.log_analytics_workspace_key
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}