module "resourceGroup" {
  source      = "./modules/resourceGroup"
  rg_name     = var.rg_name
  rg_location = var.rg_location
}

module "vnet" {
  source           = "./modules/VNet"
  rg_name          = module.resourceGroup.rg_name
  rg_location      = module.resourceGroup.rg_location
  vnet_name        = var.azureVnet_name
  vnet_addr_space  = var.vnet_addr_space
  vnet_dns_servers = var.vnet_dns_servers
}


module "subnet" {
  source             = "./modules/Subnets"
  subnet_name        = var.subnet_name
  rg_name            = module.resourceGroup.rg_name
  vnet_name          = module.vnet.vnet_name
  subnet_addr_prefix = var.subnet_addr_prefix
}
module "nic" {
  source      = "./modules/NIC"
  nic_name    = var.nic_name
  rg_name     = module.resourceGroup.rg_name
  rg_location = module.resourceGroup.rg_location
  subnet_id   = module.subnet.subnet_id
}

module "vm" {
  source         = "./modules/VM"
  vm_name        = var.vm_name
  rg_name        = module.resourceGroup.rg_name
  rg_location    = module.resourceGroup.rg_location
  nic_id         = module.nic.nic_id
  vm_size        = var.vm_size
  admin_username = var.admin_username
  admin_password = var.admin_password
}