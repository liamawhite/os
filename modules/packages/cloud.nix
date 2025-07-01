{ pkgs }:

with pkgs; [
  azure-cli
  awscli2
  cmctl
  eksctl
  fluxcd
  google-cloud-sdk
  kubernetes-helm
  kubectl
  k9s
  istioctl
  podman
  qemu # required for podman
  skopeo
  terraform
  vcluster
]

