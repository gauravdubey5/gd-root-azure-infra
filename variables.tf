variable "rg" {
  description = "Resource Group configuration"
  type        = any
}

variable "vnet" {
  description = "Virtual Network configuration"
  type        = any
}

variable "subnets" {
  description = "Subnet configurations"
  type        = any
  default     = {}
}

variable "pip" {
  description = "Public IP configurations"
  type        = any
  default     = {}
}

variable "nic" {
  description = "Network Interface configurations"
  type        = any
  default     = {}
}

variable "nsg" {
  description = "Network Security Group configurations"
  type        = any
  default     = {}
}

variable "route_tables" {
  description = "Route Table configurations"
  type        = any
  default     = {}
}

variable "nat_gateways" {
  description = "NAT Gateway configurations"
  type        = any
  default     = {}
}

variable "load_balancers" {
  description = "Load Balancer configurations"
  type        = any
  default     = {}
}

variable "application_gateways" {
  description = "Application Gateway configurations"
  type        = any
  default     = {}
}

variable "managed_disks" {
  description = "Managed Disk configurations"
  type        = any
  default     = {}
}

variable "virtual_machines" {
  description = "Virtual Machine configurations"
  type        = any
  default     = {}
}
