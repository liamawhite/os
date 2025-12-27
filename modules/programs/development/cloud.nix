{ user, pkgs, ... }:

let
  fortio = pkgs.buildGoModule rec {
    pname = "fortio";
    version = "1.69.5";

    src = pkgs.fetchFromGitHub {
      owner = "fortio";
      repo = "fortio";
      rev = "v${version}";
      sha256 = "sha256-Z1BJhWjCJtTOOhXbia56PjkvJbom4ofQVdmxYts3AyU=";
    };

    vendorHash = "sha256-A8wAfM6GN4NUVuZFhadiaaJPinPRHCjs2L+CRflwqFI=";

    ldflags = [
      "-s"
      "-w"
      "-X fortio.org/fortio/version.shortVersion=${version}"
    ];

    # Tests hang due to server lifecycle issues in CLI tests
    doCheck = false;

    meta = with pkgs.lib; {
      description = "Load testing library, command line tool, advanced echo server and web UI";
      homepage = "https://github.com/fortio/fortio";
      license = licenses.asl20;
      maintainers = [ ];
    };
  };
in
{
  home-manager.users.${user} = { ... }: {
    home.packages = with pkgs; [
      azure-cli
      awscli2
      cloudflared
      cmctl
      crd2pulumi
      docker-compose
      eksctl
      fortio
      fluxcd
      google-cloud-sdk
      kind
      kubernetes-helm
      kubectl
      kubectx
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

