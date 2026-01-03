variable "nsg_name" {}
variable "rg_location" {}
variable "rg_name" {}
variable "nsg_tags" {
  type = map(string)
}

variable "security_rules" {
  type = list(object({
    name             = string
    priority         = number
    direction        = string
    access           = string
    protocol         = string
    source_port      = string
    destination_port = string
    source           = string
    destination      = string
  }))
}
