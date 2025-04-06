variable "ssh_public_key_path" {
    description = "Path to the SSH public key"
    type        = string
}

variable "target_node" {
  description = "The Proxmox node to deploy to"
  type        = string
}

variable "datastore" {
    description = "The Proxmox datastore to use"
    type        = string
}