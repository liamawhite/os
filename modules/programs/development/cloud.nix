{ user, pkgs, ... }:

{
  home-manager.users.${user} = { ... }: {
    home.packages = with pkgs; [
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
      minikube
      podman
      qemu # required for podman
      skopeo
      terraform
      vcluster
    ];
  };
}

