module "vm_nic" {
  source      = "./modules/NIC"
  nic_name    = var.nic_name
  rg_name     = module.resourceGroup.rg_name
  rg_location = module.resourceGroup.rg_location
  subnet_id   = module.subnet.subnet_id
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