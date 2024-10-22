resource1 = {
  rs = {
    resource_group_name = "karan1"
    location            = "Centralindia"
  }
}

virtual_network = {
  vnn = {
    virtual_network_name = "karanvnet"
    resource_group_name  = "karan1"
    location             = "Centralindia"
  }
}

sub88 = {
  sub1 = {
    subnet_name          = "karansub1"
    virtual_network_name = "karanvnet"
    resource_group_name  = "karan1"
    address_prefixes     = ["10.0.2.0/24"]
  }
  sub2 = {
    subnet_name          = "karansub2"
    virtual_network_name = "karanvnet"
    resource_group_name  = "karan1"
    address_prefixes     = ["10.0.3.0/24"]
  }
  sub3 = {
    subnet_name          = "AzureBastionSubnet"
    virtual_network_name = "karanvnet"
    resource_group_name  = "karan1"
    address_prefixes     = ["10.0.4.0/24"]
  }

}

vm = {
  vmachine1 = {
    vm-name              = "karanvm1"
    subnet-name          = "karansub1"
    virtual_network_name = "karanvnet"
    resource_group_name  = "karan1"
    nic-name             = "karannic1"
    location             = "Centralindia"
    kv-name              = "kvlock"
  }
  vmachine2 = {
    vm-name              = "karanvm2"
    subnet-name          = "karansub2"
    virtual_network_name = "karanvnet"
    resource_group_name  = "karan1"
    nic-name             = "karannic2"
    location             = "Centralindia"
    kv-name              = "kvlock"
  }
}

kv = {
  key = {
    kv-name             = "kvlock"
    resource_group_name = "karan1"
    location            = "Centralindia"
  }
}

bastion = {
  ba = {
    pip-name             = "karanpip"
    resource_group_name  = "karan1"
    location             = "Centralindia"
    bastion-name         = "karanbastion"
    virtual_network_name = "karanvnet"
  }
}
