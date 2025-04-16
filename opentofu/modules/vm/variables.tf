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

variable "cloud_image" {
    description = "The cloud image to use"
    type        = string
}

variable "user_data_cloud_config_id" {
    description = "The ID of the cloud-init user data file"
    type        = string
}

variable "vlan_id" {
  description = "The VLAN ID to use"
  type        = number
  default     = 0
}