# global provider variables
variable "proxmox_api_url" {
  description = "The URL of the Proxmox API"
  type        = string
}

variable "proxmox_username" {
  description = "The username for Proxmox"
  type        = string
  default     = "root"
}

variable "proxmox_password" {
  description = "The password for Proxmox"
  type        = string
  sensitive   = true
}

variable "proxmox_api_token" {
  description = "The API token for Proxmox"
  type        = string
  sensitive   = true
}

# VM module variables
variable "name" {
  description = "The name of the VM"
  type        = string
}

variable "target_node" {
  description = "The Proxmox node to deploy to"
  type        = string
}

variable "id" {
  description = "The id of the VM"
  type        = number
}

variable "template" {
  description = "The name of the template to clone"
  type        = bool
  default     = false
}

variable "clone" {
  description = "The name of the VM to clone"
  type        = string
}

variable "machine" {
  description = "The machine type"
  type        = string
  default     = "q35"
}

variable "bios" {
  description = "The BIOS type"
  type        = string
  default     = "ovmf"
}

variable "description" {
  description = "Description of the VM"
  type        = string
}

variable "agent_enabled" {
  description = "Enable the agent"
  type        = bool
  default     = true
}

variable "cpu_cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 1
}

variable "cpu_sockets" {
  description = "Number of CPU sockets"
  type        = number
  default     = 1
}

variable "cpu_type" {
  description = "CPU type"
  type        = string
  default     = "host"
}

variable "memory" {
  description = "Memory in MB"
  type        = number
  default     = 2048
}

variable "os_disk_size" {
  description = "Size of the disk"
  type        = string
  default     = "20G"
}

variable "datastore" {
  description = "Datastore to use"
  type        = string
  default     = "local-lvm"
}

variable "network_bridge" {
  description = "The network bridge to use"
  type        = string
  default     = "vmbr1"
}

variable "address" {
  description = "The IP address of the VM"
  type        = string
}

variable "gateway" {
  description = "The gateway of the VM"
  type        = string
}

variable "nameserver" {
  description = "The nameserver of the VM"
  type        = string
}

variable "ssh_public_key_path" {
  description = "The SSH public key to use for cloud-init"
  type        = string
}
