# { stdenv, buildGoModule, fetchFromGitHub }:
{ pkgs }:
with pkgs;

# https://nixos.org/manual/nixpkgs/stable/#sec-language-go
buildGoModule rec {
  pname = "rapture";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "daveadams";
    repo = "go-rapture";
    rev = "v${version}";
    sha256 = "sha256-aqY/O6mE2nQPNhRhuHUpXSD/CYyvMSHJ9KzsacWkKmQ="
  };

  vendorHash = "sha256-+xqTeDLyNagXmm6Aj6Up8lccAa67ygYvapA+Y6ZeFzQ=";
  ldFlags="-w -s";
  subPackages = [ "cmd/rapture" ];

  meta = with stdenv.lib; {
    description = "Shell-integrated CLI for assuming AWS IAM roles";
    homepage = src.meta.homepage;
  };
}
