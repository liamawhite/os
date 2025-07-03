{ user, pkgs, ... }:

{
  home-manager.users.${user} = { ... }: {
    home.packages = with pkgs; [
      azure-cli
      awscli2
      cmctl
      docker-compose
      eksctl
      fluxcd
      google-cloud-sdk
      kubernetes-helm
      kubectl
      kubelogin
      k9s
      istioctl
      minikube
      podman
      qemu # required for podman
      skaffold
      skopeo
      terraform
      vcluster
    ];
  };
}

