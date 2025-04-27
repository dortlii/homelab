#!/bin/bash

# install operator and crds
# kubectl create -f https://operatorhub.io/install/argocd-operator.yaml

# https://kostis-argo-cd.readthedocs.io/en/refresh-docs/getting_started/install/#using-plain-kubernetes-manifests
kubectl create argocd
kubectl -n argocd apply -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl -n argocd patch configmap argocd-cm --patch-file patch.yaml
