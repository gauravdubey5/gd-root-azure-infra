environment         = "prod"
location            = "eastus2"
resource_group_name = "rg-gd-platform-prod-001"
vnet_name           = "vnet-gd-platform-prod-001"
vnet_address_space  = ["10.30.0.0/16"]
vnet_dns_servers    = []
nsg_name            = "nsg-gd-platform-prod-001"

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
    description                = "Allow production internal HTTPS traffic"
  }
]

subnets = {
  "snet-workload-prod-01" = {
    address_prefixes  = ["10.30.1.0/24"]
    associate_nsg     = true
    service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
  },
  "snet-data-prod-01" = {
    address_prefixes  = ["10.30.2.0/24"]
    associate_nsg     = true
    service_endpoints = ["Microsoft.Sql", "Microsoft.Storage"]
  }
}

tags = {
  DeploymentType = "Automated"
  Owner          = "Gaurav"
  Compliance     = "PCI-DSS-Ready"
}
