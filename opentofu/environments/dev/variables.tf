variable "proxmox_api_url" {
  type      = string
}

variable "proxmox_api_token" {
  type      = string
  sensitive = true
}

variable "proxmox_username" {
  type      = string
  default   = "root"
}

variable "proxmox_password" {
  type      = string
  sensitive = true
}

variable "vms" {
  description = "List of VMs to create"
  type = list(object({
    id             = number
    name           = string
    description    = string
    target_node    = string
    template       = bool
    clone          = string
    memory         = number
    cpu_cores      = number
    cpu_type       = string
    os_disk_size   = string
    datastore      = string
    ip_address     = string
    gateway        = string
    nameserver     = string
    network_bridge = string
  }))
}