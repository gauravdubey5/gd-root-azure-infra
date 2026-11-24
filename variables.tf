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
