# ============================================
# AZURE FREE TIER NETWORK LAB
# ============================================
# All resources are within Azure free tier limits
# VNet, Subnets, NSGs = Always Free
# Log Analytics = 5GB/month free
# Network Watcher = Base features free
# ============================================

# Resource Group
resource "azurerm_resource_group" "lab" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location
  tags     = local.common_tags
}

# Network Module
module "network" {
  source = "./modules/network"
  
  resource_group_name = azurerm_resource_group.lab.name
  location            = azurerm_resource_group.lab.location
  project_name        = var.project_name
  environment         = var.environment
  
  vnet_address_space  = var.vnet_address_space
  subnet_config       = var.subnet_config
  
  tags = local.common_tags
}

# Monitoring Module
module "monitoring" {
  source = "./modules/monitoring"
  
  resource_group_name = azurerm_resource_group.lab.name
  location            = azurerm_resource_group.lab.location
  project_name        = var.project_name
  environment         = var.environment
  
  vnet_id             = module.network.vnet_id
  subnet_ids          = module.network.subnet_ids
  nsg_id              = module.network.nsg_id
  
  alert_email         = var.alert_email
  tags                = local.common_tags
}
