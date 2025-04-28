#!/bin/bash

# =============================================================================
# Script Name:    arch.sh
# Description:    Sets up a Arch installation for personal usage
# Usage:          ./arch.sh
# Author:         Fabian Dort <fabian@dortlii.dev>
# Maintainer:     Fabian Dort <fabian@dortlii.dev>
# Version:        1.0.0
# License:        GNU GPLv3
# Dependencies:   sudo permissions
#
# History:
#   Version 1.0.0 - Initial release
# =============================================================================

#-----------------------------------------
# functions
#-----------------------------------------
beauty_output() {
  echo "#-----------------------------------------------------------------------------------------------"
}

#-----------------------------------------
# install tools with dnf
#-----------------------------------------
YAY_TOOLS=(
  "kitty"
  "flatpak"
  "seahorse"
  "gcr"
  "zsh"
  "git"
  "stow"
  "wget"
  "virt-viewer"
  "tmux"
  "xclip"
  "bat"
  "ansible"
  "polybar"
  "playerctl"
  "vim"
  "neovim"
  "1password"
  "1password-cli"
  "seahorse"
  "gnome-keyring"
  "git-delta"
  "visual-studio-code-bin"
  "spotify"
  # "nvidia-settings"
  "zen-browser-bin"
  "nvm"
  "oh-my-posh"
  "sqlite"
  "jq"
  "kompose"
  "gettext"
  "kubectx"
  "git"
  "kubent"
  "kubernetes"
  "yamllint"
  "go-yq"
  "gnupg"
  "go"
  "qemu"
  "helm"
  "skopeo"
  "dotnet-sdk"
  "helm"
  "argocd"
  "terraform"
  "kubectx"
  "opentofu"
  "grype"
  "syft"
  "packer"
  "kubebuilder"
  "k9s"
  "ansible-lint"
  "talosctl"
  "pulumi"
  "lazygit"
  "neovim"
  "npm"
  "fzf"
  "git-delta"
  "eza"
  "fd"
  "git-cliff"
  "rust-analyzer"
  "kubecolor"
  "kwallet"
  "kwalletmanager"
  "kwallet-pam"
  "apple_cursor"
  "bruno-bin"
  "ghostty"
  "brave-bin"
  "jetbrains-toolbox"
  "podman-desktop-bin"
  "podman"
  "zip"
  "edid-decode"
  "zed"
  "rofi-wayland"
  "grimblast"
  "swappy"
  "libnotify"
)

beauty_output
echo "installing all the yay tools ..."
yay -Sq "${YAY_TOOLS[@]}"

#-----------------------------------------
# installing fonts
#-----------------------------------------
FONTS_CUSTOM_FOLDER="/usr/local/share/fonts"

MONASPACE_VERSION="v1.101"
JETBRAINS_MONO_VERSION="v3.2.1"

if [[ ! -d $FONTS_CUSTOM_FOLDER/monaspace && ! -d $FONTS_CUSTOM_FOLDER/jetbrainsmono ]]; then
  beauty_output
  echo "Creating folders for new fonts ..."
  sudo mkdir -p $FONTS_CUSTOM_FOLDER/{monaspace,jetbrainsmono}

  echo "Downloading and installing monaspace font ..."
  wget "https://github.com/githubnext/monaspace/releases/download/$MONASPACE_VERSION/monaspace-$MONASPACE_VERSION.zip"
  unzip monaspace-$MONASPACE_VERSION.zip
  sudo mv monaspace-v1.101/fonts/otf/* $FONTS_CUSTOM_FOLDER/monaspace/
  rm -r monaspace-$MONASPACE_VERSION.zip monaspace-v1.101 __MACOSX

  echo "Downloading and installing JetBrains Mono font ..."
  wget "https://github.com/ryanoasis/nerd-fonts/releases/download/$JETBRAINS_MONO_VERSION/JetBrainsMono.zip"
  unzip JetBrainsMono.zip
  sudo mv Jet*.ttf $FONTS_CUSTOM_FOLDER/jetbrainsmono/
  rm OFL.txt README.md JetBrainsMono.zip

  sudo chown -R root: $FONTS_CUSTOM_FOLDER/{monaspace,jetbrainsmono}
  sudo chmod 644 $FONTS_CUSTOM_FOLDER/{monaspace,jetbrainsmono}/*

  echo "updating font cache ..."
  sudo fc-cache -v
else
  beauty_output
  echo "Fonts alread installed - skipping ..."
fi

#-----------------------------------------
# create default folders
#-----------------------------------------
beauty_output

echo "create dev folders ..."
mkdir -p ~/dev/git/{git-server,github,gitlab,gitea}

beauty_output

#-----------------------------------------
# echo infos about the tools
#-----------------------------------------
echo
echo
echo "#-----------------------------------------------------------------------------------------------"
echo ">> NOTES <<"
echo "#-----------------------------------------------------------------------------------------------"
echo "To save your gpg password inside the keyring"
echo "create a 'default' keyring and unlock it"
echo "#-----------------------------------------------------------------------------------------------"
echo "Install brew for linux:"
echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
echo "#-----------------------------------------------------------------------------------------------"
echo "Install oh-my-zsh"
echo 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
echo "#-----------------------------------------------------------------------------------------------"
echo "Install oh-my-zsh plugins ..."
echo 'git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions'
echo 'git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting'
echo "#-----------------------------------------------------------------------------------------------"
