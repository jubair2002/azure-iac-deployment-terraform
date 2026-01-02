module "private_aks" {
  source = "./modules/AKS-private"

  aks_name   = var.aks_name
  dns_prefix = var.aks_dns_prefix

  rg_name  = module.resourceGroup.rg_name
  location = module.resourceGroup.rg_location

  subnet_id = module.subnet.subnet_id

  node_count = var.aks_node_count
  aks_vm_size    = var.aks_node_vm_size

  tags = {
    environment = var.aks_environment
    owner       = "devops"
    project     = "private-aks"
  }
}