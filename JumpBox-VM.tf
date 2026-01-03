module "vm_nic" {
  source      = "./modules/NIC"
  nic_name    = var.nic_name
  rg_name     = module.resourceGroup.rg_name
  rg_location = module.resourceGroup.rg_location
  subnet_id   = module.vm_subnet.subnet_id
}

module "jumpbox_vm" {
  source         = "./modules/VM"
  vm_name        = var.vm_name
  rg_name        = module.resourceGroup.rg_name
  rg_location    = module.resourceGroup.rg_location
  nic_id         = module.vm_nic.nic_id
  vm_size        = var.vm_size
  admin_username = var.admin_username
  admin_password = var.admin_password
}

module "jumpbox_vm_nsg" {
  source   = "./modules/NSG"
  nsg_name = "nsg-jumpbox"
  rg_location = module.resourceGroup.rg_location
  rg_name  = module.resourceGroup.rg_name

  security_rules = [
    {
      name             = "Allow-SSH"
      priority         = 100
      direction        = "Inbound"
      access           = "Allow"
      protocol         = "Tcp"
      source_port      = "*"
      destination_port = "22"
      source           = "*"
      destination      = "*"
    }
  ]

  nsg_tags = {
    env = "prod"
  }
}
resource "azurerm_subnet_network_security_group_association" "jumpbox_nsg" {
  subnet_id                 = module.vm_subnet.subnet_id
  network_security_group_id = module.jumpbox_vm_nsg.nsg_id
}
