data "azurerm_key_vault_secret" "root_public_ssh_key" {
  name         = var.root_ssh_key_secret_name
  key_vault_id = var.root_ssh_key_key_vault_id
}

#resource "azurerm_lb" "main" {
#  name                = format("lb-%s-%s", var.environment, var.vm_name)
#  location            = var.location
#  resource_group_name = var.rg_name
#  sku                 = var.lb_sku
#
#  frontend_ip_configuration {
#    name                          = "Internal"
#    subnet_id                     = var.subnet_id
#    private_ip_address_allocation = "Dynamic"
#  }
#
#  tags = var.tags
#}
#
#resource "azurerm_lb_backend_address_pool" "bpool" {
#  name            = format("bap-%s-%s", var.environment, var.vm_name)
#  loadbalancer_id = azurerm_lb.main.id
#}

resource "azurerm_linux_virtual_machine_scale_set" "main" {
  name                = format("vmss-%s-%s", var.environment, var.vm_name)
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = var.vm_sku
  instances           = var.instances
  admin_username      = var.vm_admin_username

  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = data.azurerm_key_vault_secret.root_public_ssh_key.value
  }

  disable_password_authentication = true

  source_image_reference {
    publisher = var.source_image_publisher
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = var.source_image_version
  }

  network_interface {
    name    = format("nic-%s-%s", var.environment, var.vm_name)
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id
      #load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpool.id]
      application_gateway_backend_address_pool_ids = var.application_gateway_backend_address_pool_ids
    }
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  data_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
    disk_size_gb         = var.data_disk_size
    lun                  = 10
  }

  #identity {
  #  type         = "SystemAssigned, UserAssigned"
  #  identity_ids = var.user_assigned_ids
  #}

  /*extension {
    auto_upgrade_minor_version = true
    name                       = "DependencyAgentLinux"
    publisher                  = "Microsoft.Azure.Monitoring.DependencyAgent"
    type                       = "DependencyAgentLinux"
    type_handler_version       = "9.5"
  }

  extension {
    name                       = "AzureMonitorLinuxAgent"
    publisher                  = "Microsoft.Azure.Monitor"
    type                       = "AzureMonitorLinuxAgent"
    type_handler_version       = "1.0"
    auto_upgrade_minor_version = "true"
  }*/

  /*dynamic "extension" {
    for_each = var.extensions
    content {
      name                       = extension.value.name
      publisher                  = extension.value.publisher
      type                       = extension.value.type
      type_handler_version       = extension.value.type_handler_version
      auto_upgrade_minor_version = extension.value.auto_upgrade_minor_version
      protected_settings         = extension.value.protected_settings
      provision_after_extensions = extension.value.provision_after_extensions
      settings                   = extension.value.settings
    }
  }*/

  # Since these can change via auto-scaling outside of Terraform,
  # let's ignore any changes to the number of instances

  lifecycle {
    ignore_changes = ["instances"]
  }

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "main" {
  name                = format("ascl-cfg-%s-%s", var.environment, var.vm_name)
  resource_group_name = var.rg_name
  location            = var.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.main.id

  profile {
    name = "AutoScale"

    capacity {
      default = var.instances
      minimum = var.instances_min
      maximum = var.instances_max
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.main.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = var.autoscale_cpu_thresold_increase
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.main.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = var.autoscale_cpu_thresold_decrease
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }

  tags = var.tags
}

resource "azurerm_monitor_data_collection_rule" "monitoring_collection_rule" {
  name                = format("lcr-%s-%s", var.environment, var.vm_name)
  resource_group_name = var.rg_name
  location            = var.location

  destinations {
    log_analytics {
      workspace_resource_id = var.log_analytics_workspace_id
      name                  = format("logs-%s-%s", var.environment, var.vm_name)
    }

    azure_monitor_metrics {
      name = format("metrics-%s-%s", var.environment, var.vm_name)
    }
  }

  data_flow {
    streams      = ["Microsoft-InsightsMetrics"]
    destinations = [format("logs-%s-%s", var.environment, var.vm_name)]
  }

  data_sources {
    performance_counter {
      streams                       = ["Microsoft-InsightsMetrics"]
      sampling_frequency_in_seconds = 60
      counter_specifiers            = ["\\VmInsights\\DetailedMetrics"]
      name                          = "VMInsightsPerfCounters"
    }

    syslog {
      facility_names = ["*"]
      log_levels     = ["*"]
      name           = format("syslog-%s-%s", var.environment, var.vm_name)
    }
  }
}

resource "azurerm_monitor_data_collection_rule_association" "monitoring_collection_rule_association" {
  name                    = format("mon-assoc-%s-%s", var.environment, var.vm_name)
  target_resource_id      = azurerm_linux_virtual_machine_scale_set.main.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.monitoring_collection_rule.id
  description             = format("vmss-%s-%s", var.environment, var.vm_name)
}