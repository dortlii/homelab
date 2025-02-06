# ansible_intra

This is my awesome Ansible repository with playbooks and installation guides.

## install colletions with ansible-galaxy

```console
ansible-galaxy install -r requirements.yml
```

### Generate SSH Keys

```console
# Generate an ssh key
ssh-keygen -t ed25519 -C "fabian main"

# Copy the ssh key to the server(s)
ssh-copy-id -i ~/.ssh/<ssh-key-name>.pub <IP-Address>

# Generate an ssh key that's going to be specifically used for Ansible
ssh-keygen -t ed25519 -C "ansible"

# Copy the ssh key to the server(s)
ssh-copy-id -i ~/.ssh/ansible.pub

# Use an SSH key to connect to a server
ssh -i .ssh/<key_name> <IP Address>

# To cache the passphrase for our session, we can use the ssh agent
eval $(ssh-agent)
ssh-add

# Here's an alias you can put in your .bashrc, to simplify it
alias ssha='eval $(ssh-agent) && ssh-add'
```

## Source

[Wiki LearnLinuxTV](https://wiki.learnlinux.tv/index.php/Getting_Started_with_Ansible_02_-_SSH_overview_%26_Setup)
