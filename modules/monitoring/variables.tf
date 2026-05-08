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

variable "vnet_id" {
  description = "Virtual Network ID"
  type        = string
}

variable "subnet_ids" {
  description = "Map of subnet IDs"
  type        = map(string)
}

variable "nsg_id" {
  description = "Network Security Group ID"
  type        = string
}

variable "alert_email" {
  description = "Email for alerts"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}
