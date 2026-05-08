# ============================================
# MONITORING MODULE - FREE TIER COMPATIBLE
# ============================================

# Get resource group ID for activity log alert scopes
data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

# Log Analytics Workspace - 5GB/month FREE
resource "azurerm_log_analytics_workspace" "main" {
  name                = "law-${var.project_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "PerGB2018"
  retention_in_days   = 30 # Keep within free limits

  tags = var.tags
}

# Action Group for Alerts - FREE FOR BASIC ALERTS
resource "azurerm_monitor_action_group" "main" {
  name                = "ag-${var.project_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  short_name          = "NetAlerts"
  enabled             = true

  email_receiver {
    name                    = "NetworkAdmin"
    email_address           = var.alert_email
    use_common_alert_schema = true
  }

  tags = var.tags
}

# Activity Log Alert for NSG Changes - FREE
resource "azurerm_monitor_activity_log_alert" "nsg_changes" {
  name                = "alert-nsg-changes-${var.project_name}"
  resource_group_name = var.resource_group_name
  scopes              = [data.azurerm_resource_group.main.id]
  description         = "Alert when NSG rules are modified"

  criteria {
    category       = "Administrative"
    resource_type  = "Microsoft.Network/networkSecurityGroups"
    operation_name = "Microsoft.Network/networkSecurityGroups/write"
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

  tags = var.tags
}

# Activity Log Alert for VNet Changes - FREE
resource "azurerm_monitor_activity_log_alert" "vnet_changes" {
  name                = "alert-vnet-changes-${var.project_name}"
  resource_group_name = var.resource_group_name
  scopes              = [data.azurerm_resource_group.main.id]
  description         = "Alert when VNet configuration changes"

  criteria {
    category       = "Administrative"
    resource_type  = "Microsoft.Network/virtualNetworks"
    operation_name = "Microsoft.Network/virtualNetworks/write"
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

  tags = var.tags
}
