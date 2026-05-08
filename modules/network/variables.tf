variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
}

variable "subnet_config" {
  description = "Subnet configuration"
  type = map(object({
    name             = string
    address_prefixes = list(string)
    purpose          = string
  }))
}

variable "allowed_admin_ips" {
  description = "Whitelisted public IPs allowed for SSH access"
  type        = list(string)
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}
