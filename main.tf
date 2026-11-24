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

# 4. Public IP
module "pip" {
  depends_on = [module.rg]
  source     = "git::https://github.com/gauravdubey5/gd-child-public-ip.git?ref=v1.0.4"
  public_ip  = var.pip
}

# 5. Network Interface
module "nic" {
  depends_on        = [module.rg, module.subnet, module.pip]
  source            = "git::https://github.com/gauravdubey5/gd-child-nic.git?ref=v1.0.4"
  network_interface = var.nic
}
