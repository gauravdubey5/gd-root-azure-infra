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
  sensitive   = true
}

output "vnet_peerings" {
  description = "The created Virtual Network Peerings."
  value       = module.vnet_peering.vnet_peerings
}

output "private_endpoints" {
  description = "The created Private Endpoints."
  value       = module.private_endpoint.private_endpoints
}

output "storage_accounts" {
  description = "The created Storage Accounts."
  value       = module.storage_account.storage_accounts
  sensitive   = true
}

output "storage_account_ids" {
  description = "The created Storage Account IDs."
  value       = module.storage_account.storage_account_ids
}

output "app_service_plans" {
  description = "The created App Service Plans."
  value       = module.app_service_plan.app_service_plans
}

output "web_app_ids" {
  description = "The created Web App IDs."
  value       = module.web_app.web_app_ids
}

output "web_app_default_hostnames" {
  description = "The created Web App default hostnames."
  value       = module.web_app.web_app_default_hostnames
}

output "postgresql_servers" {
  description = "The created PostgreSQL Flexible Servers."
  value       = module.postgresql_database.postgresql_servers
  sensitive   = true
}

output "postgresql_server_fqdns" {
  description = "The created PostgreSQL Flexible Server FQDNs."
  value       = module.postgresql_database.postgresql_server_fqdns
}

output "key_vaults" {
  description = "The created Azure Key Vaults."
  value       = module.key_vault.key_vaults
}
