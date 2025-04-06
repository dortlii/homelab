terraform {
  backend "local" {}
  # Or use S3, GitLab, etc.
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.74.1"
    }
  }
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

locals {
  target_node = "hades"
}

module "cloud_config" {
  source = "../../modules/cloud_config"

  ssh_public_key_path = "../../../homelab-files/opentofu/ssh.pub"
  datastore        = "local"
  target_node = local.target_node
}

module "cloud_image" {
  source = "../../modules/cloud_image"

  datastore = "local"
  image_url = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  target_node = local.target_node
}

module "vm" {
  source = "../../modules/vm"

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
  cloud_image    = module.cloud_image.image_url_id
  user_data_cloud_config_id = module.cloud_config.user_data_cloud_config
}
