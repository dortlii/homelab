#!/bin/bash

install_operators() {
  echo "Installing cert manager operator"
  cert-manager/install-operator.sh

  echo "Installing argocd operator"
  argocd/install-operator.sh
}

# setup olm
./setup_olm.sh

# install traefik
traefik/install-chart.sh

# install operators
install_operators

# install cert-manager

