{ pkgs }:
with pkgs;

# https://nixos.org/manual/nixpkgs/stable/#sec-language-go
buildGoModule rec {
  pname = "temporal";
  version = "1.1.2";

  src = fetchFromGitHub {
    owner = "temporalio";
    repo = "cli";
    rev = "v${version}";
    sha256 = "sha256-7wURMdi357w5S4s909PTUZanRzFyWM588DMY7iYWP88=";
  };

  vendorHash = "sha256-ifXNp3xYHrl/cQgSYi/epdx8NH1W1FBSCq6iuD0dQ/o=";
  ldFlags = "-s -w -X github.com/temporalio/cli/temporalcli.Version=${version}";
  subPackages = [ "cmd/temporal" ];

  meta = with stdenv.lib; {
    description = "Command-line interface for running Temporal Server and interacting with Workflows, Activities, Namespaces, and other parts of Temporal";
    homepage = src.meta.homepage;
  };
}
