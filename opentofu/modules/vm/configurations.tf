data "local_file" "ssh_public_key" {
  filename = var.ssh_public_key_path
}

locals {
  ubuntu_img_url = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  datastore = "local"
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = local.datastore
  node_name    = var.target_node

  url = local.ubuntu_img_url
}

resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = local.datastore
  node_name    = var.target_node

  source_raw {
    data = <<-EOF
    #cloud-config
    users:
      - default
      - name: fabian
        groups:
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${trimspace(data.local_file.ssh_public_key.content)}
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
        - apt update
        - apt install -y qemu-guest-agent net-tools
        - timedatectl set-timezone Europe/Zurich
        - systemctl enable qemu-guest-agent
        - systemctl start qemu-guest-agent
        - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "user-data-cloud-config.yaml"
  }
}