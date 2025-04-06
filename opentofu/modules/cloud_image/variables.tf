variable "image_url" {
    description = "The URL of the cloud image to download"
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