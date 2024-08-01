{ pkgs }:
with pkgs;

# https://nixos.org/manual/nixpkgs/stable/#sec-language-go
buildGoModule rec {
  pname = "nt";
  version = "v0.0.2";

  src = fetchFromGitHub {
    owner = "liamawhite";
    repo = "nt";
    rev = "${version}";
    sha256 = "sha256-ajUDpa/czDI1xMU7DvqZ9ktyC32L/dbLpnTX5YGt7m4=";
  };

  vendorHash = "sha256-0yQMrQXAc7MPEXvOYl1INCj1k4HzViFVeMzv16XCK40=";
  ldFlags = "-w -s";

  meta = with stdenv.lib; {
    description = "A cli for interacting with my notes";
    homepage = src.meta.homepage;
  };
}
