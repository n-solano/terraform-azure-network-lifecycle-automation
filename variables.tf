# ============================================
# REQUIRED VARIABLES
# ============================================

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "netlab"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "demo"], var.environment)
    error_message = "Environment must be dev, test, or demo."
  }
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "alert_email" {
  description = "Email for network alerts"
  type        = string
  default     = "admin@example.com"
}

variable "allowed_admin_ips" {
  description = "Whitelisted public IPs allowed for SSH access"
  type        = list(string)
  default     = ["10.20.19.4/32"]
}

# ============================================
# NETWORK CONFIGURATION
# ============================================

variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
  default     = ["10.1.0.0/16"]
}

variable "subnet_config" {
  description = "Subnet configuration"
  type = map(object({
    name             = string
    address_prefixes = list(string)
    purpose          = string
  }))
  default = {
    web = {
      name             = "snet-web"
      address_prefixes = ["10.1.1.0/24"]
      purpose          = "Web tier - Public facing applications"
    }
    app = {
      name             = "snet-app"
      address_prefixes = ["10.1.2.0/24"]
      purpose          = "Application tier - Business logic"
    }
    data = {
      name             = "snet-data"
      address_prefixes = ["10.1.3.0/24"]
      purpose          = "Data tier - Databases and storage"
    }
    mgmt = {
      name             = "snet-mgmt"
      address_prefixes = ["10.1.4.0/24"]
      purpose          = "Management - Monitoring and bastion"
    }
  }
}

# ============================================
# LOCAL VALUES
# ============================================

locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    CostCenter  = "Free-Tier-Lab"
    Purpose     = "Network-Demonstration"
  }
}
