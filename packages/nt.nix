{ pkgs }:
with pkgs;

# https://nixos.org/manual/nixpkgs/stable/#sec-language-go
buildGoModule rec {
  pname = "nt";
  version = "v0.0.1";

  src = fetchFromGitHub {
    owner = "liamawhite";
    repo = "nt";
    rev = "${version}";
    sha256 = "sha256-KNr3PJUc0A0InaTAFOJeKVexHkvzI4ss8xpNGho1AJ8=";
  };

  vendorHash = "sha256-0yQMrQXAc7MPEXvOYl1INCj1k4HzViFVeMzv16XCK40=";
  ldFlags="-w -s";

  meta = with stdenv.lib; {
    description = "A cli for interacting with my notes";
    homepage = src.meta.homepage;
  };
}
