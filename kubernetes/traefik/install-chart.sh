#!/bin/bash

helm install \
  traefik \
  traefik/traefik \
  --values init-values.yaml \
  --namespace traefik \
  --create-namespace
