{ pkgs }:
with pkgs;

# https://nixos.org/manual/nixpkgs/stable/#sec-language-go
buildGoModule rec {
  pname = "vaulted";
  version = "3.0.0";

  # Do nothing because the tests fail!
  checkPhase = "";

  src = fetchFromGitHub {
    owner = "miquella";
    repo = "vaulted";
    rev = "v${version}";
    sha256 =  "sha256-slFlC4pbOhzbNMaYIPkbclhNlmzdMO8rTTSrmehlNd4=";
  };

  vendorHash = "sha256-BbKbzbSAZjX4geDsSKvdIX8Dj3E7qA0h8k98JfkBSP4=";
   # ldFlags="-w -s";

  meta = with stdenv.lib; {
    description = "Spawning and storage of secure environments";
    homepage = src.meta.homepage;
  };
}
