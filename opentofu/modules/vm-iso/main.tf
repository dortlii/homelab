terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.76.0"
    }
  }
}

resource "proxmox_virtual_environment_vm" "vm" {

  lifecycle {
    ignore_changes = [
      started,
      initialization
    ]
  }

  name      = var.name
  node_name = var.target_node
  vm_id     = var.id

  template = var.template

  machine     = var.machine
  bios        = var.bios
  description = var.description

  agent {
    enabled = var.agent_enabled
  }

  cpu {
    cores   = var.cpu_cores
    sockets = var.cpu_sockets
    type    = var.cpu_type
  }

  memory {
    dedicated = var.memory
  }

  efi_disk {
    datastore_id = "local-lvm"
    file_format  = "raw"
    type         = "4m"
  }

  cdrom {
    file_id      = var.iso
    interface    = "ide2"
  }

  disk {
    interface    = "virtio0"
    size         = var.os_disk_size
    datastore_id = var.datastore
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

    user_data_file_id = var.user_data_cloud_config_id
  }

  network_device {
    bridge = var.network_bridge
    vlan_id = var.vlan_id
  }

}
