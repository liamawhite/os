{ pkgs }:
with pkgs;

# https://nixos.org/manual/nixpkgs/stable/#sec-language-go
buildGoModule rec {
  pname = "nt";
  version = "255e801dd858ccbc63bd7d960a1aea0448519ddf";

  src = fetchFromGitHub {
    owner = "liamawhite";
    repo = "nt";
    rev = "${version}";
    sha256 = "sha256-c2fzt42SLw/94Ww21nAd85GT3nctsRjrL75uB3J824w=";
  };

  vendorHash = "sha256-0yQMrQXAc7MPEXvOYl1INCj1k4HzViFVeMzv16XCK40=";
  ldFlags="-w -s";

  meta = with stdenv.lib; {
    description = "A cli for interacting with my notes";
    homepage = src.meta.homepage;
  };
}
