module "private_aks" {
  source = "./modules/AKS-private"

  aks_name   = var.aks_name
  dns_prefix = var.aks_dns_prefix

  rg_name  = module.resourceGroup.rg_name
  location = module.resourceGroup.rg_location

  subnet_id = module.aks_subnet.subnet_id

  node_count     = var.aks_node_count
  aks_vm_size    = var.aks_node_vm_size
  app_gateway_id = module.app_gateway.appgw_id

  tags = {
    environment = var.aks_environment
    owner       = "devops"
    project     = "private-aks"
  }
}
module "aks_nsg" {
  source   = "./modules/NSG"
  nsg_name = "nsg-aks"
  rg_location = module.resourceGroup.rg_location
  rg_name  = module.resourceGroup.rg_name

  security_rules = [
    {
      name             = "Allow-AppGW-To-AKS"
      priority         = 100
      direction        = "Inbound"
      access           = "Allow"
      protocol         = "*"
      source_port      = "*"
      destination_port = "*"
      source           = module.appgw_subnet.subnet_address_prefix
      destination      = "*"
    }
  ]

  nsg_tags = {
    env = "prod"
  }
}
resource "azurerm_subnet_network_security_group_association" "aks" {
  subnet_id                 = module.aks_subnet.subnet_id
  network_security_group_id = module.aks_nsg.nsg_id
}
