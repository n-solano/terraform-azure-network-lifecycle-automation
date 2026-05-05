# ============================================
# NETWORK MODULE - FREE TIER RESOURCES
# ============================================

# Virtual Network - ALWAYS FREE
resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.project_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.vnet_address_space
  
  tags = var.tags
}

# Subnets - ALWAYS FREE
resource "azurerm_subnet" "main" {
  for_each             = var.subnet_config
  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = each.value.address_prefixes
}

# Network Security Group - ALWAYS FREE
resource "azurerm_network_security_group" "main" {
  name                = "nsg-${var.project_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  
  # Default deny-all inbound, allow-all outbound
  security_rule {
    name                       = "DenyAllInbound"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  
  tags = var.tags
}

# Associate NSG with all subnets - ALWAYS FREE
resource "azurerm_subnet_network_security_group_association" "main" {
  for_each                  = azurerm_subnet.main
  subnet_id                 = each.value.id
  network_security_group_id = azurerm_network_security_group.main.id
}

# Network Watcher - FREE BASE FEATURES
resource "azurerm_network_watcher" "main" {
  name                = "nw-${var.project_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  
  tags = var.tags
}
