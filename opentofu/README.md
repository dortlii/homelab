# OpenTofu

## Prerequisites

Most of the more sensitive data are stored in `auto.tfvars` files. 
These files are not included in the repository. You will need to create them yourself.
Here are the templates for the `auto.tfvars` files:

```hcl
# creds.auto.tfvars
proxmox_api_url          = "https://pve.exmaple.com:8006/"  # Your Proxmox Address
proxmox_api_token_id     = "terraform-prov@pve!deploy"      # API Token ID
proxmox_api_token_secret = "seceret"                        # API Token Secret
```

```hcl
# vm-vars.auto.tfvars
# INFO: always add the vm id to the prefix like `vm_101_`, `vm_102_` to the variable name
vm_100_id   = 100
vm_100_name = "server-name"
vm_100_ip   = "10.0.0.1"
# ...

vm_101_id   = 101
vm_101_name = "worker-name"
vm_101_ip   = "10.0.0.2"
# ...
```

## Usage

```bash

```