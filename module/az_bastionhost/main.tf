resource "azurerm_public_ip" "pip" {
    for_each = var.bastion
  name                = each.value.pip-name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bhost" {
    for_each = var.bastion
  name                = each.value.bastion-name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.bastionsubnetdata[each.key].id
    public_ip_address_id = azurerm_public_ip.pip[each.key].id
  }
}
data "azurerm_subnet" "bastionsubnetdata" {
    for_each = var.bastion
  name                 = "AzureBastionSubnet"
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}