terraform {
  backend "local" {}  # Or use S3, GitLab, etc.
}

module "global" {
  source = "../../global"

  proxmox_api_url   = var.proxmox_api_url
  proxmox_api_token = var.proxmox_api_token
  proxmox_username  = var.proxmox_username
  proxmox_password  = var.proxmox_password
}

module "vm" {
  source = "../../modules/vm"

  ssh_public_key_path = "../../../homelab-files/opentofu/ssh.pub"

  for_each = { for idx, vm in var.vms : vm.name => vm }

  id             = each.value.id
  name           = each.value.name
  description    = each.value.description
  target_node    = each.value.target_node
  clone          = each.value.clone
  template       = each.value.template
  memory         = each.value.memory
  cpu_cores      = each.value.cpu_cores
  cpu_type       = each.value.cpu_type
  os_disk_size   = each.value.os_disk_size
  datastore      = each.value.datastore
  address        = each.value.ip_address
  gateway        = each.value.gateway
  nameserver     = each.value.nameserver
  network_bridge = each.value.network_bridge
}
