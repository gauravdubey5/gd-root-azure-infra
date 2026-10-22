locals {
  common_tags = merge(
    {
      Environment = var.environment
      Project     = "CloudPlatform"
      ManagedBy   = "Terraform"
      CostCenter  = "Infrastructure"
    },
    var.tags
  )
}

# 1. Resource Group
module "rg" {
  source = "git::https://github.com/gauravdubey5/gd-child-rg.git?ref=v1.0.0"

  name       = var.resource_group_name
  location   = var.location
  lock_level = var.environment == "prod" ? "CanNotDelete" : null
  tags       = local.common_tags
}

# 2. Virtual Network
module "vnet" {
  source = "git::https://github.com/gauravdubey5/gd-child-vnet.git?ref=v1.0.0"

  name                = var.vnet_name
  resource_group_name = module.rg.name
  location            = module.rg.location
  address_space       = var.vnet_address_space
  dns_servers         = var.vnet_dns_servers
  tags                = local.common_tags
}

# 3. Network Security Group
module "nsg" {
  source = "git::https://github.com/gauravdubey5/gd-child-nsg.git?ref=v1.0.0"

  name                = var.nsg_name
  resource_group_name = module.rg.name
  location            = module.rg.location
  security_rules      = var.security_rules
  tags                = local.common_tags
}

# 4. Subnets
module "subnet" {
  source = "git::https://github.com/gauravdubey5/gd-child-subnet.git?ref=v1.0.1"

  for_each = var.subnets

  name                             = each.key
  resource_group_name              = module.rg.name
  virtual_network_name             = module.vnet.name
  address_prefixes                 = each.value.address_prefixes
  associate_network_security_group = each.value.associate_nsg
  network_security_group_id        = each.value.associate_nsg ? module.nsg.id : null
  service_endpoints                = each.value.service_endpoints
}
