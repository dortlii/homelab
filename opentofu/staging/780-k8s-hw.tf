resource "proxmox_virtual_environment_vm" "jumpbox" {
  vm_id      = var.vm_config["vm_780"].id
  name      = "jumpbox"

  node_name = local.node
  tags = [
    "opentofu",
    "jumpbox",
    "kubernetes",
  ]

  clone {
    vm_id = proxmox_virtual_environment_vm.ubuntu_template.id
  }

  // resource configuration
  cpu {
    cores = 1
    sockets = 1
    type = "host"
  }

  memory {
    dedicated = 1024
  }

  // qemu agent
  agent {
    enabled = true
  }

  // cloud-init configuration
  initialization {
    dns {
      servers = [var.nameserver_ip]
    }
    ip_config {
      ipv4 {
        address = var.vm_config["vm_780"].ip
        gateway = var.gateway_ip
      }
    }
    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
  }

  // os disk
  disk {
    datastore_id = var.vm_config["vm_780"].os_datastore_id
    size         = 32
    interface    = "virtio1"
  }

  // network configuration
  network_device {
    firewall = false
    bridge = var.vm_config["vm_780"].bridge
  }
}
