variable "environment" {
  description = "Target deployment environment (dev, staging, prod)."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: 'dev', 'staging', 'prod'."
  }
}

variable "location" {
  description = "Primary Azure region for all resources."
  type        = string
  default     = "eastus2"
}

variable "resource_group_name" {
  description = "Name of the base Resource Group."
  type        = string
}

variable "vnet_name" {
  description = "Name of the Virtual Network."
  type        = string
}

variable "vnet_address_space" {
  description = "CIDR block(s) for the Virtual Network."
  type        = list(string)
}

variable "vnet_dns_servers" {
  description = "Custom DNS servers list for the VNet."
  type        = list(string)
  default     = []
}

variable "nsg_name" {
  description = "Name of the base Network Security Group."
  type        = string
}

variable "security_rules" {
  description = "Security rules to attach to the baseline NSG."
  type = list(object({
    name                         = string
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_port_range            = optional(string)
    source_port_ranges           = optional(list(string))
    destination_port_range       = optional(string)
    destination_port_ranges      = optional(list(string))
    source_address_prefix        = optional(string)
    source_address_prefixes      = optional(list(string))
    destination_address_prefix   = optional(string)
    destination_address_prefixes = optional(list(string))
    description                  = optional(string)
  }))
  default = []
}

variable "subnets" {
  description = "Map of subnets to create within the Virtual Network."
  type = map(object({
    address_prefixes  = list(string)
    associate_nsg     = optional(bool, true)
    service_endpoints = optional(list(string), [])
  }))
  default = {}
}

variable "tags" {
  description = "Additional tags to merge with common tags."
  type        = map(string)
  default     = {}
}
