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

output "network_security_groups" {
  description = "The created Network Security Groups."
  value       = module.nsg.network_security_groups
}

output "route_tables" {
  description = "The created Route Tables."
  value       = module.route_table
}

output "nat_gateways" {
  description = "The created NAT Gateways."
  value       = module.nat_gateway
}

output "load_balancers" {
  description = "The created Load Balancers."
  value       = module.lb.load_balancers
}

output "application_gateways" {
  description = "The created Application Gateways."
  value       = module.app_gateway.application_gateways
}

output "managed_disks" {
  description = "The created Managed Disks."
  value       = module.os_disk.managed_disks
}

output "virtual_machines" {
  description = "The created Linux Virtual Machines."
  value       = module.vm.linux_virtual_machines
}
