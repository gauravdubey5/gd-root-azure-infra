rg = {
  rg1 = {
    name     = "dev-gd_linux_vm_rg"
    location = "central india"
  }
}

vnet = {
  vnet1 = {
    name                = "dev-gd-linux-vnet"
    location            = "central india"
    resource_group_name = "dev-gd_linux_vm_rg"
    address_space       = ["10.0.0.0/16"]
  }
}

subnets = {
  subnet1 = {
    name                 = "dev-gd-linux-subnet-frontend"
    resource_group_name  = "dev-gd_linux_vm_rg"
    virtual_network_name = "dev-gd-linux-vnet"
    address_prefixes     = ["10.0.1.0/24"]
  }
  subnet2 = {
    name                 = "dev-gd-linux-subnet-backend"
    resource_group_name  = "dev-gd_linux_vm_rg"
    virtual_network_name = "dev-gd-linux-vnet"
    address_prefixes     = ["10.0.2.0/24"]
  }
  subnet3 = {
    name                 = "dev-gd-linux-subnet-database"
    resource_group_name  = "dev-gd_linux_vm_rg"
    virtual_network_name = "dev-gd-linux-vnet"
    address_prefixes     = ["10.0.3.0/24"]
  }
}

pip = {
  Public_IP1 = {
    name                = "dev-gd-linux-ip"
    resource_group_name = "dev-gd_linux_vm_rg"
    location            = "central india"
    allocation_method   = "Static"
  }
}

nic = {
  nic1 = {
    name                          = "dev-gd-linux-nic"
    location                      = "central india"
    resource_group_name           = "dev-gd_linux_vm_rg"
    public_ip_name                = "dev-gd-linux-ip"
    subnet_name                   = "dev-gd-linux-subnet"
    ip_config_name                = "config123"
    virtual_network_name          = "dev-gd-linux-vnet"
    private_ip_address_allocation = "Dynamic"
  }
}


nsg = {
  nsg1 = {
    name                = "gd-linux-nsg"
    location            = "central india"
    resource_group_name = "dev-gd_linux_vm_rg"
  }
}

virtual_machines = {
  frontend_1 = {
    name                = "dev-gd-linux-vm-frontend"
    location            = "central india"
    resource_group_name = "dev-gd_linux_vm_rg"
    nic_name            = "dev-gd-linux-nic"
    size                = "Standard_B1s"
    admin_username      = "devopsadmin"
    admin_password      = "ComplexPassword123!"
    image_publisher     = "Canonical"
    image_offer         = "0001-com-ubuntu-server-jammy"
    image_sku           = "22_04-lts"
    image_version       = "latest"
  }
}

route_tables = {
  rt1 = {
    name                = "rt-dev-001"
    resource_group_name = "dev-gd_linux_vm_rg"
    location            = "central india"
    routes              = []
  }
}

nat_gateways = {
  nat1 = {
    name                = "nat-dev-001"
    resource_group_name = "dev-gd_linux_vm_rg"
    location            = "central india"
  }
}

load_balancers = {
  lb1 = {
    name                = "lb-dev-001"
    resource_group_name = "dev-gd_linux_vm_rg"
    location            = "central india"
  }
}

application_gateways = {}
# Uncomment and supply valid subnet_id and public_ip_address_id to provision Application Gateway:
# application_gateways = {
#   appgw1 = {
#     name                 = "appgw-dev-001"
#     resource_group_name  = "dev-gd_linux_vm_rg"
#     location             = "central india"
#     subnet_id            = "/subscriptions/.../subnets/..."
#     public_ip_address_id = "/subscriptions/.../publicIPAddresses/..."
#   }
# }
