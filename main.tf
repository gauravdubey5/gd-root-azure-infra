# 1. Resource Group
module "rg" {
  source         = "git::https://github.com/gauravdubey5/gd-child-rg.git?ref=v1.0.4"
  resource_group = var.rg
}

# 2. Virtual Network
module "vnet" {
  depends_on      = [module.rg]
  source          = "git::https://github.com/gauravdubey5/gd-child-vnet.git?ref=v1.0.4"
  virtual_network = var.vnet
}

# 3. Subnets
module "subnet" {
  depends_on = [module.vnet]
  source     = "git::https://github.com/gauravdubey5/gd-child-subnet.git?ref=v1.0.4"
  subnets    = var.subnets
}

# 4. Network Security Group
module "nsg" {
  depends_on             = [module.rg]
  source                 = "git::https://github.com/gauravdubey5/gd-child-nsg.git?ref=v1.0.4"
  network_security_group = var.nsg
}

# 5. Route Table
module "route_table" {
  for_each                      = var.route_tables
  source                        = "git::https://github.com/gauravdubey5/gd-child-route-table.git?ref=v1.0.4"
  name                          = each.value.name
  resource_group_name           = each.value.resource_group_name
  location                      = each.value.location
  bgp_route_propagation_enabled = lookup(each.value, "bgp_route_propagation_enabled", true)
  routes                        = lookup(each.value, "routes", [])
  tags                          = lookup(each.value, "tags", {})
}

# 6. Public IP
module "pip" {
  depends_on = [module.rg]
  source     = "git::https://github.com/gauravdubey5/gd-child-public-ip.git?ref=v1.0.4"
  public_ip  = var.pip
}

# 7. NAT Gateway
module "nat_gateway" {
  for_each                = var.nat_gateways
  source                  = "git::https://github.com/gauravdubey5/gd-child-nat-gateway.git?ref=v1.0.4"
  name                    = each.value.name
  resource_group_name     = each.value.resource_group_name
  location                = each.value.location
  sku_name                = lookup(each.value, "sku_name", "Standard")
  idle_timeout_in_minutes = lookup(each.value, "idle_timeout_in_minutes", 4)
  zones                   = lookup(each.value, "zones", ["1"])
  public_ip_address_ids   = lookup(each.value, "public_ip_address_ids", [])
  subnet_ids              = lookup(each.value, "subnet_ids", [])
  tags                    = lookup(each.value, "tags", {})
}

# 8. Network Interface
module "nic" {
  depends_on        = [module.rg, module.subnet, module.pip]
  source            = "git::https://github.com/gauravdubey5/gd-child-nic.git?ref=v1.0.4"
  network_interface = var.nic
}

# 9. Load Balancer
module "lb" {
  depends_on     = [module.rg, module.pip, module.subnet]
  source         = "git::https://github.com/gauravdubey5/gd-child-lb.git?ref=v1.0.0"
  load_balancers = var.load_balancers
}

# 10. Application Gateway
module "app_gateway" {
  depends_on           = [module.rg, module.pip, module.subnet]
  source               = "git::https://github.com/gauravdubey5/gd-child-app-gateway.git?ref=v1.0.0"
  application_gateways = { for k, v in var.application_gateways : k => v if try(v.subnet_id, "") != "" && try(v.public_ip_address_id, "") != "" }
}

# 11. Managed Disks
module "os_disk" {
  depends_on    = [module.rg]
  source        = "git::https://github.com/gauravdubey5/gd-child-os-disk.git?ref=v1.0.0"
  managed_disks = var.managed_disks
}

# 12. Virtual Machines
module "vm" {
  depends_on       = [module.rg, module.nic]
  source           = "git::https://github.com/gauravdubey5/gd-child-vm.git?ref=v1.0.0"
  virtual_machines = var.virtual_machines
}

# 13. VNet Peering
module "vnet_peering" {
  depends_on    = [module.vnet]
  source        = "git::https://github.com/gauravdubey5/gd-child-vnet-peering.git?ref=v1.0.0"
  vnet_peerings = var.vnet_peerings
}

# 14. Storage Account
module "storage_account" {
  depends_on       = [module.rg]
  source           = "git::https://github.com/gauravdubey5/gd-child-storage-account.git?ref=v1.0.0"
  storage_accounts = var.storage_accounts
}

# 15. App Service Plan
module "app_service_plan" {
  depends_on        = [module.rg]
  source            = "git::https://github.com/gauravdubey5/gd-child-app-services.git?ref=v1.0.0"
  app_service_plans = var.app_service_plans
}

# 16. Web App
module "web_app" {
  depends_on = [module.rg, module.app_service_plan, module.subnet]
  source     = "git::https://github.com/gauravdubey5/gd-child-web-app.git?ref=v1.0.0"
  web_apps   = var.web_apps
}

# 17. PostgreSQL Database
module "postgresql_database" {
  depends_on         = [module.rg, module.subnet]
  source             = "git::https://github.com/gauravdubey5/gd-child-postgresql-database.git?ref=v1.0.0"
  postgresql_servers = var.postgresql_servers
}

# 18. Key Vault
module "key_vault" {
  depends_on = [module.rg]
  source     = "git::https://github.com/gauravdubey5/gd-child-keyvault.git?ref=v1.0.0"
  key_vaults = var.key_vaults
}

# 19. Private Endpoint
module "private_endpoint" {
  depends_on        = [module.rg, module.subnet, module.storage_account, module.key_vault, module.postgresql_database, module.web_app]
  source            = "git::https://github.com/gauravdubey5/gd-child-private-endpoint.git?ref=v1.0.0"
  private_endpoints = var.private_endpoints
}
