variable "rg_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "azureVnet_name" {
  type = string
}

variable "vnet_addr_space" {
  type = list(string)
}
variable "rg_location" {
  type = string
}
variable "vnet_dns_servers" {
  type = list(string)
}
variable "subnet_addr_prefix" {
  type = list(string)
}
variable "nic_name" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "aks_name" {
  type = string
}
variable "aks_dns_prefix" {}

variable "aks_node_count" {
  default = 1
}

variable "aks_node_vm_size" {
  default = "Standard_D2_v2"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "aks_environment" {
  type = string
}
variable "appgw_subnet_name" {
  type = string
}
variable "subnet_addr_prefix_appgw" {
  type = list(string)
}