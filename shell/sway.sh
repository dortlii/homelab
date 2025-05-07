#!/bin/bash

# =============================================================================
# Script Name:    sway.sh
# Description:    Sets up a sway installation for personal usage
# Usage:          ./sway.sh
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
  "sway"
  "swaybg"
  "hyprland-polkit"
  "grim"
  "swappy"
)

beauty_output
echo "installing all the yay tools ..."
yay -Sq "${YAY_TOOLS[@]}"
