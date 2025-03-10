terraform {
  backend "local" {} # Or use S3, GitLab, etc.
}

provider "proxmox" {
  endpoint  = var.proxmox_api_url
  api_token = var.proxmox_api_token
  insecure  = true
  ssh {
    agent    = true
    username = var.proxmox_username
    password = var.proxmox_password
  }
}

terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.73.0"
    }
  }
}

module "vm" {
  source = "../../modules/vm"

  proxmox_api_url = var.proxmox_api_url
  proxmox_password = var.proxmox_password
  proxmox_api_token = var.proxmox_api_token

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
  network_bridge  = each.value.network_bridge
}
