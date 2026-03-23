# kubetype-gen: Istio Kubernetes type generator
# Generates Go types from Kubernetes CRDs for Istio projects
# Part of the istio/tools repository, not available in nixpkgs
# See: https://github.com/istio/tools/tree/master/cmd/kubetype-gen

{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "kubetype-gen";
  version = "unstable-2024-01-01";

  src = fetchFromGitHub {
    owner = "istio";
    repo = "tools";
    rev = "master";
    hash = "sha256-/C0Lzw7Jbq3TatGaTxSYIP+l6SA3mQwOgGFSsrcZwV4=";
  };

  # The tool is in a subdirectory of the repo
  subPackages = [ "cmd/kubetype-gen" ];

  vendorHash = "sha256-yYcVqfI6ccgLNQ+AVc8m1XrJ+XAaf6nvLvcEfQnYUDg=";

  doCheck = false;

  meta = with lib; {
    description = "Istio Kubernetes type generator";
    homepage = "https://istio.io";
    license = licenses.asl20;
    maintainers = [ ];
  };
}
