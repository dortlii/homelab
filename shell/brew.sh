#!/bin/bash

# command to install linux brew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 1 time config
# test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
# test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
# echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile

CLI_TOOLS=(
  "nvm"
  "oh-my-posh"
  "sqlite"
  "jq"
  "kompose"
  "gettext"
  "kubectx"
  "git"
  "kubent"
  "git-flow"
  "kubernetes-cli"
  "yamllint"
  "yq"
  "podman"
  "podman-compose"
  "zsh-autosuggestions"
  "zsh-syntax-highlighting"
  "zsh-completions"
  "gnupg"
  "go"
  "qemu"
  "helm"
  "skopeo"
  "dotnet-sdk"
  "helm"
  "kubernetes-cli"
  "argocd"
  "terraform"
  "kubectx" # https://github.com/ahmetb/kubectx
  "opentofu"
  "kubeconform"
  "grype"
  "syft"
  "packer"
  "kubebuilder"
  "derailed/k9s/k9s"
  "ansible-lint"
  "siderolabs/tap/talosctl"
  "pulumi/tap/pulumi"
  "jesseduffield/lazygit/lazygit"
  "neovim"
  "npm"
  "fzf"
  "git-delta"
  "eza"
  "fd"
  "git-cliff"
  "rust-analyzer"
  "kubecolor"
)

MAC_TOOLS=(
  "powershell"
  "1password"
  "fig"
  "google-chrome"
  "microsoft-teams"
  "spotify"
  "firefox"
  "gpg-suite"
  "obsidian"
  "visual-studio-code"
  "citrix-workspace"
  "appcleaner"
  "hiddenbar"
  "podman-desktop"
  "cyberduck"
  "iterm2"
  "bruno"
  "rectangle"
)

for tool in "${CLI_TOOLS[@]}"; do
  brew install "$tool"
done

if [ "$(uname -s)" != "Linux" ]; then
  for mac_tool in "${MAC_TOOLS[@]}"; do
    brew install "$mac_tool"
  done
fi
