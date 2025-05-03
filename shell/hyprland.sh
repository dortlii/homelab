#!/bin/bash

# =============================================================================
# Script Name:    hyprland.sh
# Description:    Sets up a hyprland installation for personal usage
# Usage:          ./hyprland.sh
# Author:         Fabian Dort <fabian@dortlii.dev>
# Maintainer:     Fabian Dort <fabian@dortlii.dev>
# Version:        1.0.0
# License:        GNU GPLv3
# Dependencies:
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
  "cmake"
  "meson"
  "cpio"
  "pkg-config"
)

beauty_output
echo "installing all the yay tools ..."
yay -Sq "${YAY_TOOLS[@]}"

#-----------------------------------------
# update hyprland plugins
#-----------------------------------------
beauty_output
echo "updating hyprland plugin manager ..."
hyprpm update -v

hyprpm add https://github.com/hyprwm/hyprland-plugins

#-----------------------------------------
# update hyprland plugins
#-----------------------------------------
HYPRLAND_PLUGINS=(
  "hyprexpo"
)
beauty_output
echo "installing all the yay tools ..."
hyprpm enable "${HYPRLAND_PLUGINS[@]}"
