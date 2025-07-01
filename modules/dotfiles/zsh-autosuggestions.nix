{ pkgs }:
with pkgs;

stdenv.mkDerivation rec {
  pname = "zsh-autosuggestions";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "zsh-users";
    repo = "zsh-autosuggestions";
    rev = "v${version}";
    sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
  };

  installPhase = ''
    mkdir -p $out/zsh
    cp -r zsh-autosuggestions.zsh $out/zsh/zsh-autosuggestions.zsh
  '';

  meta = {
    description = "Fish shell autosuggestions for Zsh";
    homepage = "https://github.com/zsh-users/zsh-autosuggestions";
  };
}
