environment         = "staging"
location            = "eastus2"
resource_group_name = "rg-gd-platform-staging-001"
vnet_name           = "vnet-gd-platform-staging-001"
vnet_address_space  = ["10.20.0.0/16"]
vnet_dns_servers    = []
nsg_name            = "nsg-gd-platform-staging-001"

security_rules = [
  {
    name                       = "Allow-HTTPS-Inbound"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
    description                = "Allow staging internal HTTPS traffic"
  }
]

subnets = {
  "snet-workload-staging-01" = {
    address_prefixes  = ["10.20.1.0/24"]
    associate_nsg     = true
    service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
  },
  "snet-data-staging-01" = {
    address_prefixes  = ["10.20.2.0/24"]
    associate_nsg     = true
    service_endpoints = ["Microsoft.Sql", "Microsoft.Storage"]
  }
}

tags = {
  DeploymentType = "Automated"
  Owner          = "Gaurav"
}
