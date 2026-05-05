output "vnet_id" {
  description = "Virtual Network ID"
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "Virtual Network name"
  value       = azurerm_virtual_network.main.name
}

output "subnet_ids" {
  description = "Map of subnet names to IDs"
  value       = { for k, v in azurerm_subnet.main : k => v.id }
}

output "subnet_details" {
  description = "Detailed subnet information"
  value = {
    for k, v in azurerm_subnet.main : k => {
      name            = v.name
      id              = v.id
      address_prefix  = v.address_prefixes[0]
    }
  }
}

output "nsg_id" {
  description = "Network Security Group ID"
  value       = azurerm_network_security_group.main.id
}

output "nsg_name" {
  description = "Network Security Group name"
  value       = azurerm_network_security_group.main.name
}

output "network_watcher_name" {
  description = "Network Watcher name"
  value       = azurerm_network_watcher.main.name
}
