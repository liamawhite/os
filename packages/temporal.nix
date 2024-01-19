{ pkgs }:
with pkgs;

# https://nixos.org/manual/nixpkgs/stable/#sec-language-go
buildGoModule rec {
  pname = "temporal";
  version = "0.10.7";

  src = fetchFromGitHub {
    owner = "temporalio";
    repo = "cli";
    rev = "v${version}";
    sha256 = "sha256-pFVCy6xB7Fhj4OatyNQdjkDpDGtod2nJsg2vdl5ED9s=";
  };

  vendorHash = "sha256-VzY7m5HIsqH3GkHw1YFFL/zAOyR6Hq9MgxlIilU83FM=";
  ldFlags="-w -s -X github.com/temporalio/cli/headers.Version=${version}";
  subPackages = [ "cmd/temporal" ];

  meta = with stdenv.lib; {
    description = "Command-line interface for running Temporal Server and interacting with Workflows, Activities, Namespaces, and other parts of Temporal";
    homepage = src.meta.homepage;
  };
}
