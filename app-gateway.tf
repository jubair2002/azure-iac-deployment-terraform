module "app_gateway" {
  source         = "./modules/Application-Gateway"
  appgw_name     = "appgw-prod-101"
  public_ip_name = "appgw-prod-pip-101"
  rg_name        = module.resourceGroup.rg_name
  location       = module.resourceGroup.rg_location
  subnet_id      = module.appgw_subnet.subnet_id

  tags = {
    environment = "prod"
  }
}

module "appgw_nsg" {
  source   = "./modules/NSG"
  nsg_name = "nsg-appgw"
  rg_location = module.resourceGroup.rg_location
  rg_name  = module.resourceGroup.rg_name

  security_rules = [
    {
      name             = "Allow-HTTP-HTTPS"
      priority         = 100
      direction        = "Inbound"
      access           = "Allow"
      protocol         = "Tcp"
      source_port      = "*"
      destination_port = "80"
      source           = "Internet"
      destination      = "*"
    },
    {
      name             = "Allow-HTTPS"
      priority         = 110
      direction        = "Inbound"
      access           = "Allow"
      protocol         = "Tcp"
      source_port      = "*"
      destination_port = "443"
      source           = "Internet"
      destination      = "*"
    },
    {
      name             = "Allow-Azure-LB"
      priority         = 120
      direction        = "Inbound"
      access           = "Allow"
      protocol         = "*"
      source_port      = "*"
      destination_port = "65200-65535"
      source           = "AzureLoadBalancer"
      destination      = "*"
    }
  ]

  nsg_tags = {
    env = "prod"
  }
}
resource "azurerm_subnet_network_security_group_association" "appgw" {
  subnet_id                 = module.appgw_subnet.subnet_id
  network_security_group_id = module.appgw_nsg.nsg_id
}
