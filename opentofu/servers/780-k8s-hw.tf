data "local_file" "ssh_public_key" {
  filename = "../../homelab-files/opentofu/ssh.pub"
}

variable "vm_config" {
  type = map(object({
    id   = number
    name = string
    ip   = string
  }))
}

variable "local_username" {
  type = string
}

variable "gateway_ip" {
  type = string
}

variable "nameserver_ip" {
    type = string
}

locals {
  ubuntu_img_url = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = local.iso_datastore
  node_name    = local.node

  url = local.ubuntu_img_url
}

resource "proxmox_virtual_environment_vm" "jumpbox" {
  vm_id      = var.vm_config["vm_780"].id
  name      = "jumpbox"

  node_name = local.node
  tags = [
    "opentofu",
    "jumpbox",
    "kubernetes",
  ]

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
      nameservers = [var.nameserver_ip]
    }
    user_account {
      keys = [trimspace(data.local_file.ssh_public_key.content)]
      username = var.local_username
    }
    ip_config {
      ipv4 {
        address = var.vm_config["vm_780"].ip
        gateway = var.gateway_ip
      }
    }
  }

  // cloud-init disk
  disk {
    datastore_id = local.cid_datastore
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  // os disk
  disk {
    datastore_id = var.vm_config["vm_780"].os_datastore_id
    size         = 32
    interface    = "virtio1"
  }

  // network configuration
  network_device {
    bridge = var.vm_config["vm_780"].bridge
  }
}
