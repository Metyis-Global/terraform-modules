output "lb_public_ip_address" {
  description = "Load Balancer Public Address"
  value       = azurerm_public_ip.lb_pip.ip_address
}

# Load Balancer ID
output "lb_id" {
  description = "Load Balancer ID."
  value       = azurerm_lb.lb.id
}

# Load Balancer Frontend IP Configuration Block
output "lb_frontend_ip_configuration" {
  description = "LB frontend_ip_configuration Block"
  value       = [azurerm_lb.lb.frontend_ip_configuration]
}