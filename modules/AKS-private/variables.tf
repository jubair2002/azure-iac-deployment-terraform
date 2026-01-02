variable "aks_name" {}
variable "location" {}
variable "rg_name" {}
variable "dns_prefix" {}

variable "subnet_id" {
  type = string
}

variable "node_count" {
  default = 1
}

variable "aks_vm_size" {
  default = "Standard_D2_v2"
}

variable "tags" {
  type    = map(string)
  default = {}
}
