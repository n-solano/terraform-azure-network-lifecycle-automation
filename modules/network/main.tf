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

resource "azurerm_network_security_rule" "allow_ssh_whitelist" {
  name                        = "AllowSshFromWhitelist"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefixes     = var.allowed_admin_ips
  destination_address_prefix  = azurerm_subnet.main["mgmt"].address_prefixes[0]
  network_security_group_name = azurerm_network_security_group.main.name
  resource_group_name         = var.resource_group_name
}

resource "azurerm_network_security_rule" "allow_web_https" {
  name                        = "AllowWebHttps"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "0.0.0.0/0"
  destination_address_prefix  = azurerm_subnet.main["web"].address_prefixes[0]
  network_security_group_name = azurerm_network_security_group.main.name
  resource_group_name         = var.resource_group_name
}

resource "azurerm_network_security_rule" "allow_app_http_https" {
  name                        = "AllowAppHttpHttps"
  priority                    = 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "443"]
  source_address_prefix       = "0.0.0.0/0"
  destination_address_prefix  = azurerm_subnet.main["app"].address_prefixes[0]
  network_security_group_name = azurerm_network_security_group.main.name
  resource_group_name         = var.resource_group_name
}

resource "azurerm_network_security_rule" "allow_app_to_data_sql" {
  name                        = "AllowAppToDataSql"
  priority                    = 130
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "1433"
  source_address_prefix       = azurerm_subnet.main["app"].address_prefixes[0]
  destination_address_prefix  = azurerm_subnet.main["data"].address_prefixes[0]
  network_security_group_name = azurerm_network_security_group.main.name
  resource_group_name         = var.resource_group_name
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
