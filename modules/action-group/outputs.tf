
/*output "action_group_id" {
  #value = azurerm_monitor_action_group.action_group.id
  value = { for key, group in azurerm_monitor_action_group.action_group : key => group.id }
  description = "The ID of the Action Group"
}
*/