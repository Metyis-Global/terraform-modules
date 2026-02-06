output "vpn_gw_id" {
  description = "The VPN gateway ID"
  value       = azurerm_point_to_site_vpn_gateway.main.id
}

output "vpn_gw_name" {
  description = "The VPN gateway name"
  value       = azurerm_point_to_site_vpn_gateway.main.name
}