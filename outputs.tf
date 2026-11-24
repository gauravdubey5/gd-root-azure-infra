output "resource_groups" {
  description = "The created Resource Groups."
  value       = module.rg.resource_groups
}

output "virtual_networks" {
  description = "The created Virtual Networks."
  value       = module.vnet.virtual_networks
}

output "subnets" {
  description = "The created subnets."
  value       = module.subnet.subnets
}

output "public_ips" {
  description = "The created Public IPs."
  value       = module.pip.public_ips
}

output "network_interfaces" {
  description = "The created Network Interfaces."
  value       = module.nic.network_interfaces
}
