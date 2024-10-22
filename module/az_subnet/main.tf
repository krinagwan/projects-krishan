resource "azurerm_subnet" "sb" {
  for_each = var.sub
  name=each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name = each.value.resource_group_name
  address_prefixes = each.value.address_prefixes
}