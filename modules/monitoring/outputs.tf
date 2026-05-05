output "workspace_name" {
  description = "Log Analytics workspace name"
  value       = azurerm_log_analytics_workspace.main.name
}

output "workspace_id" {
  description = "Log Analytics workspace ID"
  value       = azurerm_log_analytics_workspace.main.id
}

output "action_group_id" {
  description = "Action group ID"
  value       = azurerm_monitor_action_group.main.id
}
