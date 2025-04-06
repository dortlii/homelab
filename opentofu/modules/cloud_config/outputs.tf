output "user_data_cloud_config" {
  description = "The user data cloud config ID"
  value = proxmox_virtual_environment_file.user_data_cloud_config.id
}