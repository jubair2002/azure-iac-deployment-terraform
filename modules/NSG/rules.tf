resource "azurerm_network_security_rule" "rules" {
  for_each = { for r in var.security_rules : r.name => r }

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port
  destination_port_range      = each.value.destination_port
  source_address_prefix       = each.value.source
  destination_address_prefix  = each.value.destination
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}
