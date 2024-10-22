resource "azurerm_key_vault_secret" "username" {
  for_each = var.vm
  name         = "${each.value.vm-name}-username"
  value        = "${each.value.vm-name}"
  key_vault_id = data.azurerm_key_vault.key[each.key].id
}

resource "random_password" "password" {
  for_each = var.vm
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_key_vault_secret" "password" {
  for_each = var.vm
  name         = "${each.value.vm-name}-password"
  value        = random_password.password[each.key].result
  key_vault_id = data.azurerm_key_vault.key[each.key].id
}

data "azurerm_subnet" "subnetdata" {
    for_each = var.vm
  name                 = each.value.subnet-name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_key_vault" "key" {
  for_each = var.vm
  name                = each.value.kv-name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_network_interface" "nic" {
    for_each = var.vm
  name                = each.value.nic-name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnetdata[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "lvm" {
    for_each = var.vm
  name                = each.value.vm-name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  size                = "Standard_F2"
  admin_username      = azurerm_key_vault_secret.username[each.key].value
  admin_password = azurerm_key_vault_secret.password[each.key].value
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}