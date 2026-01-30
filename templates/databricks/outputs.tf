output "dbw_resourceid" {
  value       = azurerm_databricks_workspace.databricks.id
  description = "ID of the Databricks workspace"
}

output "dbw_workspace_url" {
  value = azurerm_databricks_workspace.databricks.workspace_url
}

output "cluster_id" {
  value = databricks_cluster.databricks.*.cluster_id
}