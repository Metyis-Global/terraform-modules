# AzureRM provider resources
resource "azurerm_databricks_workspace" "databricks" {
  name                          = format("dbw-%s-%s", var.environment, var.dbw_name)
  resource_group_name           = var.rg_name
  tags                          = var.tags
  location                      = var.dbw_location
  sku                           = var.dbw_sku
  managed_resource_group_name   = format("dbwm-%s-%s", var.environment, var.dbw_name)
  public_network_access_enabled = var.dbw_public_network_access_enabled

  custom_parameters {
    virtual_network_id                                   = var.dbw_vnet_id
    private_subnet_name                                  = var.dbw_private_subnet_name
    public_subnet_name                                   = var.dbw_public_subnet_name
    public_subnet_network_security_group_association_id  = var.dbw_public_subnet_id
    private_subnet_network_security_group_association_id = var.dbw_private_subnet_id
  }
}

# When deploying Databricks provider resources for the first time, you should expect an error as terraform can't create databricks workspace and get the spark version and node type in the same run.
# Please run the apply a second time if you want clusters deployed.
data "databricks_spark_version" "databricks" {
  count             = length(var.dbc_configs)
  gpu               = var.dbc_configs[count.index].dbv_gpu
  ml                = var.dbc_configs[count.index].dbv_ml
  long_term_support = var.dbc_configs[count.index].dbv_lts
  latest            = var.dbc_configs[count.index].dbv_latest
  depends_on        = [azurerm_databricks_workspace.databricks]
}

data "databricks_node_type" "databricks" {
  count      = length(var.dbc_configs)
  category   = var.dbc_configs[count.index].dbv_node_type
  depends_on = [azurerm_databricks_workspace.databricks]
}

resource "databricks_cluster" "databricks" {
  count                   = length(var.dbc_configs)
  cluster_name            = var.dbc_configs[count.index].dbc_cluster_name
  spark_version           = data.databricks_spark_version.databricks[count.index].id
  driver_node_type_id     = var.dbc_configs[count.index].dbv_driver_node_type_id
  node_type_id            = var.dbc_configs[count.index].dbv_node_type
  autotermination_minutes = var.dbc_configs[count.index].dbc_autotermination_minutes
  custom_tags             = var.dbc_configs[count.index].dbc_custom_tags
  depends_on              = [azurerm_databricks_workspace.databricks]
  spark_conf              = var.dbc_configs[count.index].dbc_spark_conf
  spark_env_vars          = var.dbc_configs[count.index].dbc_spark_env_vars
  enable_elastic_disk     = var.dbc_configs[count.index].dbc_elastic_disk
  data_security_mode      = var.dbc_configs[count.index].dbc_data_sec_mode
  runtime_engine          = var.dbc_configs[count.index].dbc_spark_runtime_engine

  autoscale {
    min_workers = var.dbc_configs[count.index].dbc_min_workers
    max_workers = var.dbc_configs[count.index].dbc_max_worker
  }

  lifecycle {
    ignore_changes = [
      custom_tags, enable_elastic_disk, state
    ]
  }
}

resource "databricks_library" "eventhubs_spark" {
  count      = length(databricks_cluster.databricks.*.cluster_id)
  cluster_id = databricks_cluster.databricks[count.index].cluster_id
  maven {
    coordinates = var.maven_coordinates_eventhub
  }
}

resource "databricks_library" "deequ_spark" {
  count      = length(databricks_cluster.databricks.*.cluster_id)
  cluster_id = databricks_cluster.databricks[count.index].cluster_id
  maven {
    coordinates = var.maven_coordinates_deequ
  }
}

resource "databricks_library" "pypi_library1" {
  count      = length(databricks_cluster.databricks.*.cluster_id)
  cluster_id = databricks_cluster.databricks[count.index].cluster_id
  pypi {
    package = var.pypi_library1
  }
}

resource "databricks_library" "pypi_library2" {
  count      = length(databricks_cluster.databricks.*.cluster_id)
  cluster_id = databricks_cluster.databricks[count.index].cluster_id
  pypi {
    package = var.pypi_library2
  }
}

resource "databricks_library" "pypi_library3" {
  count      = length(databricks_cluster.databricks.*.cluster_id)
  cluster_id = databricks_cluster.databricks[count.index].cluster_id
  pypi {
    package = var.pypi_library3
  }
}

resource "databricks_library" "pypi_library4" {
  count      = length(databricks_cluster.databricks.*.cluster_id)
  cluster_id = databricks_cluster.databricks[count.index].cluster_id
  pypi {
    package = var.pypi_library4
  }
}

resource "azurerm_monitor_diagnostic_setting" "default_settings_databricks" {
  name                       = format("DefaultSettings-dbw-%s-%s", var.environment, var.dbw_name)
  target_resource_id         = azurerm_databricks_workspace.databricks.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category_group = "allLogs"
  }
}
