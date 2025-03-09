terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      configuration_aliases = [
        proxmox.provider,
      ]
    }
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  name        = var.name
  node_name   = var.target_node
  vm_id       = var.id

  template    = var.template

  clone {
    vm_id     = var.clone
  }

  machine     = var.machine
  bios        = var.bios
  description = var.description

  agent {
    enabled   = var.agent_enabled
  }

  cpu {
    cores     = var.cpu_cores
    sockets   = var.cpu_sockets
    type      = var.cpu_type
  }

  memory {
    dedicated = var.memory
  }

  efi_disk {
    datastore_id = "local-lvm"
    file_format  = "raw"
    type         = "4m"
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  disk {
    interface     = "virtio0"
    size          = var.os_disk_size
    datastore_id  = var.datastore
  }

  initialization {
    ip_config {
      ipv4 {
        address = var.address
        gateway = var.gateway
      }
    }

    dns {
      servers = [var.nameserver]
    }

    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
  }

  network_device {
    bridge = var.network_bridge
  }

}
