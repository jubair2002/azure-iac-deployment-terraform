variable "server_name" {
  description = "The name of the SQL Server"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "server_version" {
  description = "The version of the SQL Server"
  type        = string
  default     = "12.0"
}

variable "administrator_login" {
  description = "The administrator login name for the SQL Server"
  type        = string
  sensitive   = true
}

variable "administrator_login_password" {
  description = "The administrator login password for the SQL Server"
  type        = string
  sensitive   = true
}

variable "minimum_tls_version" {
  description = "The minimum TLS version for the SQL Server"
  type        = string
  default     = "1.2"
  validation {
    condition     = contains(["1.0", "1.1", "1.2"], var.minimum_tls_version)
    error_message = "Minimum TLS version must be 1.0, 1.1, or 1.2."
  }
}

variable "azuread_admin_login_username" {
  description = "The login username of the Azure AD Administrator of this SQL Server"
  type        = string
  default     = null
}

variable "azuread_admin_object_id" {
  description = "The object id of the Azure AD Administrator of this SQL Server"
  type        = string
  default     = null
}

variable "identity_type" {
  description = "The type of Managed Service Identity that should be configured on this SQL Server"
  type        = string
  default     = "SystemAssigned"
  validation {
    condition     = contains(["SystemAssigned", "UserAssigned", "SystemAssigned,UserAssigned"], var.identity_type)
    error_message = "Identity type must be SystemAssigned, UserAssigned, or SystemAssigned,UserAssigned."
  }
}

variable "databases" {
  description = "Map of databases to create"
  type = map(object({
    name           = string
    collation      = optional(string)
    sku_name       = optional(string)
    max_size_gb    = optional(number)
    license_type   = optional(string)
    read_scale     = optional(bool)
    zone_redundant = optional(bool)
    tags           = optional(map(string))
  }))
}

variable "default_collation" {
  description = "The default collation for databases"
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "default_sku_name" {
  description = "The default SKU name for databases"
  type        = string
  default     = "S0"
}

variable "default_max_size_gb" {
  description = "The default maximum size in GB for databases"
  type        = number
  default     = 20
}

variable "default_license_type" {
  description = "The default license type for databases"
  type        = string
  default     = "LicenseIncluded"
}

variable "default_read_scale" {
  description = "The default read scale setting for databases"
  type        = bool
  default     = false
}

variable "default_zone_redundant" {
  description = "The default zone redundant setting for databases"
  type        = bool
  default     = false
}

variable "firewall_rules" {
  description = "Map of firewall rules to create"
  type = map(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))
  default = {}
}

variable "allow_azure_services" {
  description = "Whether to allow Azure services to access the SQL Server"
  type        = bool
  default     = true
}

variable "vnet_rules" {
  description = "Map of virtual network rules to create"
  type = map(object({
    name                               = string
    subnet_id                          = string
    ignore_missing_vnet_service_endpoint = optional(bool, false)
  }))
  default = {}
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}
