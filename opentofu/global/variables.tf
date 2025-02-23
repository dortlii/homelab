variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token" {
  type      = string
  sensitive = true
}

variable "proxmox_username" {
  type = string
  default = "root"
}

variable "proxmox_password" {
  type      = string
  sensitive = true
}
