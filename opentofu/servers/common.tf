data "local_file" "ssh_public_key" {
  filename = "../../homelab-files/opentofu/ssh.pub"
}

variable "gateway_ip" {
  type = string
}

variable "nameserver_ip" {
  type = string
}

variable "hostname" {
  type = string
}

variable "vm_config" {
  type = map(object({
    id   = number
    name = string
    ip   = string
    bridge = string
    os_datastore_id = string
  }))
}

resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "hades"

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: test-ubuntu
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