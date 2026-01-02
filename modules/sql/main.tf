# SQL Server Module
# This module creates Azure SQL Server and databases

resource "azurerm_mssql_server" "sql_server" {
  name                         = var.server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.server_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  minimum_tls_version          = var.minimum_tls_version

  dynamic "azuread_administrator" {
    for_each = var.azuread_admin_login_username != null && var.azuread_admin_object_id != null ? [1] : []
    content {
      login_username = var.azuread_admin_login_username
      object_id      = var.azuread_admin_object_id
    }
  }

  identity {
    type = var.identity_type
  }

  tags = var.tags
}

resource "azurerm_mssql_database" "databases" {
  for_each = var.databases

  name           = each.value.name
  server_id      = azurerm_mssql_server.sql_server.id
  collation      = lookup(each.value, "collation", var.default_collation)
  sku_name       = lookup(each.value, "sku_name", var.default_sku_name)
  max_size_gb    = lookup(each.value, "max_size_gb", var.default_max_size_gb)
  license_type   = lookup(each.value, "license_type", var.default_license_type)
  read_scale     = lookup(each.value, "read_scale", var.default_read_scale)
  zone_redundant = lookup(each.value, "zone_redundant", var.default_zone_redundant)

  tags = merge(var.tags, lookup(each.value, "tags", {}))
}

# Firewall Rules
resource "azurerm_mssql_firewall_rule" "firewall_rules" {
  for_each = var.firewall_rules

  name             = each.value.name
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}

# Azure Services Firewall Rule (Allow Azure Services)
resource "azurerm_mssql_firewall_rule" "azure_services" {
  count = var.allow_azure_services ? 1 : 0

  name             = "allow-azure-services"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# Virtual Network Rules
resource "azurerm_mssql_virtual_network_rule" "vnet_rules" {
  for_each = var.vnet_rules

  name      = each.value.name
  server_id = azurerm_mssql_server.sql_server.id
  subnet_id = each.value.subnet_id

  ignore_missing_vnet_service_endpoint = lookup(each.value, "ignore_missing_vnet_service_endpoint", false)
}
