output "mssql_database_id" {
  value       = azurerm_mssql_database.mssql_database.id
  description = "The ID of the MS SQL Database."
}

output "sql_server_id" {
  value       = azurerm_mssql_server.sql_server.id
  description = "The Microsoft SQL Server ID."
}
