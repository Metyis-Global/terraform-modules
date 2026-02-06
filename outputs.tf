#postgresql server
output "postgresql_id" {
  description = "Id of Postgresql server in Azure."
  value       = azurerm_postgresql_flexible_server.postgresql.id
}

output "postgresql_fqdn_id" {
  description = "Postgresql fqdn id"
  value       = azurerm_postgresql_flexible_server.postgresql.fqdn
}

#postgresql database
output "postgresql_db_id" {
  description = "Id of Postgresql database in Azure."
  value       = azurerm_postgresql_flexible_server_database.postgresql_db.id
}