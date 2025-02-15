#!/bin/bash

# =============================================================================
# Script Name:    fedora.sh
# Description:    Sets up a Fedora installation for personal usage
# Usage:          ./fedora.sh
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
DNF_TOOLS=(
  "kitty"
  "tlp"
  "flatpak"
  "seahorse"
  "gcr"
  "zsh"
  "git"
  "stow"
  "wget"
  "virt-viewer"
  "podman"
  "tmux"
  "xclip"
  "bat"
  "ansible"
  "polybar"
  "playerctl"
  "timeshift"
  "rofi"
)

beauty_output
echo "installing all the dnf tools ..."
sudo dnf install "${DNF_TOOLS[@]}" -y

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
  sudo restorecon -vFr $FONTS_CUSTOM_FOLDER/{monaspace,jetbrainsmono}

  echo "updating font cache ..."
  sudo fc-cache -v
else
  beauty_output
  echo "Fonts alread installed - skipping ..."
fi

#-----------------------------------------
# install 1password
#-----------------------------------------
if ! command -v 1password >/dev/null; then
  beauty_output
  echo "Installing 1password ..."

  ONEPASSWORD_RPM_FILE="1password-latest.rpm"
  wget "https://downloads.1password.com/linux/rpm/stable/x86_64/$ONEPASSWORD_RPM_FILE"
  sudo dnf install "$ONEPASSWORD_RPM_FILE" -y
  rm $ONEPASSWORD_RPM_FILE
else
  beauty_output
  echo "1password already installed - skipping ..."
fi
#-----------------------------------------
# install vscode
#-----------------------------------------
if ! command -v code >/dev/null; then
  beauty_output
  echo "Installing vs code ..."

  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo >/dev/null
  dnf check-update
  sudo dnf install code -y # or code-insiders
else
  beauty_output
  echo "code already installed - skipping ..."
fi

#-----------------------------------------
# install google cloud cli
#-----------------------------------------
if ! command -v gcloud >/dev/null; then
  beauty_output
  echo "Installing google cloud cli ..."

  sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-cli]
name=Google Cloud CLI
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el9-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM

  sudo dnf install libxcrypt-compat.x86_64 -y
  sudo dnf install google-cloud-cli google-cloud-sdk-gke-gcloud-auth-plugin -y

else
  beauty_output
  echo "gcloud already installed - skipping ..."
fi

#-----------------------------------------
# activate and enable tlp
#-----------------------------------------
if command -v tlp >/dev/null; then
  beauty_output
  echo "Starting and enabling tlp ..."

  sudo tlp start
  sudo systemctl enable tlp.service
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
echo "Launch freshly installed 'albert' via menu!"
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
