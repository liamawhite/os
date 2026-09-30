{ lib, stdenvNoCC, src }:

stdenvNoCC.mkDerivation {
  pname = "mattpocock-skills";
  version = "unstable";
  inherit src;

  installPhase = ''
    mkdir -p $out
    cp -r skills/productivity/grill-me $out/grill-me
    cp -r skills/productivity/grilling $out/grilling
    cp -r skills/engineering/grill-with-docs $out/grill-with-docs
    cp -r skills/engineering/domain-modeling $out/domain-modeling
  '';

  meta = with lib; {
    description = "Skills for Claude Code and AI agents by Matt Pocock";
    homepage = "https://github.com/mattpocock/skills";
    license = licenses.mit;
  };
}
