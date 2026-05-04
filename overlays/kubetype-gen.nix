# kubetype-gen: Istio Kubernetes type generator
# Generates Go types from Kubernetes CRDs for Istio projects
# Part of the istio/tools repository, not available in nixpkgs
# See: https://github.com/istio/tools/tree/master/cmd/kubetype-gen

{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "kubetype-gen";
  version = "unstable-2026-04-20";

  src = fetchFromGitHub {
    owner = "istio";
    repo = "tools";
    rev = "c0833221e33cd0bf80795ce91a62fe3bd5d337ed";
    hash = "sha256-XTTD/N3BrBzRmfXU07n15q0R87vc9eHHOdj4NGgVIVU=";
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
