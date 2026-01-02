module "appgw_subnet" {
  source             = "./modules/Subnets"
  subnet_name        = var.appgw_subnet_name
  rg_name            = module.resourceGroup.rg_name
  vnet_name          = module.vnet.vnet_name
  subnet_addr_prefix = var.subnet_addr_prefix_appgw
}

module "app_gateway" {
  source = "./modules/Application-Gateway"
  appgw_name     = "appgw-prod-101"
  public_ip_name = "appgw-prod-pip-101"
  rg_name        = module.resourceGroup.rg_name
  location       = module.resourceGroup.rg_location
  subnet_id      = module.appgw_subnet.subnet_id

  tags = {
    environment = "dev"
  }
}
