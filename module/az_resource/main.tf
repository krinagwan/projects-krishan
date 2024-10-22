resource "azurerm_resource_group" "rgd" {
  for_each = var.resource
  name     = each.value.resource_group_name
  location = each.value.location

}
