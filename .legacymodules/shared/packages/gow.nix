{ pkgs }:
with pkgs;

# https://nixos.org/manual/nixpkgs/stable/#sec-language-go
buildGoModule rec {
  pname = "gow";
  version = "af11a6e1e9ebccdcdace2a6df619355b85494d74";

  src = fetchFromGitHub {
    owner = "mitranim";
    repo = "gow";
    rev = "${version}";
    sha256 = "sha256-NmjJd3GVImCtYo5CxGnQHHPERx5R0sD4bzBsbxNGc3o=";
  };

  vendorHash = "sha256-Xw9V7bYaSfu5kA2505wmef2Ns/Y0RHKbZHUkvCtVNSM=";
  ldFlags = "-w -s";
  # subPackages = [ "" ];

  meta = with stdenv.lib; {
    description = "Watch go files and execute a command";
    homepage = src.meta.homepage;
  };
}
