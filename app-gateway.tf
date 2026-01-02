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
