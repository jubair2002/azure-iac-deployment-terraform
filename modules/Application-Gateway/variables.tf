variable "appgw_name" {
  type        = string
  description = "Application Gateway name"
}

variable "public_ip_name" {
  type        = string
  description = "Public IP name for Application Gateway"
}

variable "rg_name" {
  type        = string
  description = "Resource Group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID dedicated for Application Gateway"
}

variable "capacity" {
  type        = number
  default     = 2
  description = "Application Gateway instance count"
}

variable "tags" {
  type    = map(string)
  default = {}
}
