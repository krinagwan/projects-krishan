module "mresource" {
source="../module/az_resource"
resource=var.resource1  
}

module "mvnet" {
  depends_on = [ module.mresource ]
  source = "../module/az_vnet"
  vnet=var.virtual_network
}

module "msubnet" {
    depends_on = [ module.mvnet ]
    source = "../module/az_subnet"
    sub=var.sub88
}

module "mvm" {
  depends_on = [ module.msubnet ]
source = "../module/az_vm"
vm=var.vm
}

module "mkv" {
depends_on = [ module.mresource ]
source = "../module/az_kv"
  kv=var.kv
}

module "mbastion" {
  depends_on = [ module.msubnet ]
  source = "../module/az_bastionhost"
  bastion=var.bastion
}