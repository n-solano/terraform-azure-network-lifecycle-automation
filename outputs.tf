# ============================================
# OUTPUTS
# ============================================

output "resource_group" {
  description = "Resource group information"
  value = {
    name     = azurerm_resource_group.lab.name
    location = azurerm_resource_group.lab.location
  }
}

output "network" {
  description = "Network information"
  value = {
    vnet_name     = module.network.vnet_name
    vnet_id       = module.network.vnet_id
    address_space = var.vnet_address_space
  }
}

output "subnets" {
  description = "Subnet details"
  value       = module.network.subnet_details
}

output "security" {
  description = "Network security information"
  value = {
    nsg_name = module.network.nsg_name
    nsg_id   = module.network.nsg_id
  }
}

output "monitoring" {
  description = "Monitoring information"
  value = {
    log_analytics_workspace = module.monitoring.workspace_name
    network_watcher         = module.network.network_watcher_name
  }
}

output "connection_strings" {
  description = "Useful connection information"
  value = {
    vnet_uri          = "/subscriptions/.../resourceGroups/${azurerm_resource_group.lab.name}/providers/Microsoft.Network/virtualNetworks/${module.network.vnet_name}"
    log_analytics_uri = "/subscriptions/.../resourceGroups/${azurerm_resource_group.lab.name}/providers/Microsoft.OperationalInsights/workspaces/${module.monitoring.workspace_name}"
  }
  sensitive = false
}
