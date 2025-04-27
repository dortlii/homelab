#!/bin/bash

install_operators() {
  echo "Installing metallb"
  metallb/install.sh

  echo "Installing cert manager operator"
  cert-manager/install.sh

  echo "Installing argocd"
  argocd/install.sh
}

# setup olm
./setup_olm.sh

# install traefik
traefik/install-chart.sh

# install operators
install_operators

# install cert-manager

