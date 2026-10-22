output "resource_group_id" {
  description = "The Resource ID of the Resource Group."
  value       = module.rg.id
}

output "resource_group_name" {
  description = "The Name of the Resource Group."
  value       = module.rg.name
}

output "resource_group_location" {
  description = "The Location of the Resource Group."
  value       = module.rg.location
}

output "virtual_network_id" {
  description = "The Resource ID of the Virtual Network."
  value       = module.vnet.id
}

output "virtual_network_name" {
  description = "The Name of the Virtual Network."
  value       = module.vnet.name
}

output "virtual_network_address_space" {
  description = "The Address Space of the Virtual Network."
  value       = module.vnet.address_space
}

output "network_security_group_id" {
  description = "The Resource ID of the Network Security Group."
  value       = module.nsg.id
}

output "network_security_group_name" {
  description = "The Name of the Network Security Group."
  value       = module.nsg.name
}

output "subnets" {
  description = "Map of created subnets and their attributes."
  value = {
    for k, v in module.subnet : k => {
      id               = v.id
      name             = v.name
      address_prefixes = v.address_prefixes
    }
  }
}
