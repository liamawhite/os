{ user, pkgs, ... }:

let
  zen-browser = pkgs.stdenv.mkDerivation rec {
    pname = "zen-browser";
    version = "1.14.1b";

    src = pkgs.fetchurl {
      url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.macos-universal.dmg";
      sha256 = "47512a9e71c37511ace5936cbe17abec2da103fc3deb807589826e6cd8d1d7c0";
    };

    nativeBuildInputs = [ pkgs.undmg ];

    sourceRoot = ".";

    installPhase = ''
      mkdir -p $out/Applications
      cp -r "Zen.app" $out/Applications/
    '';

    meta = with pkgs.lib; {
      description = "Gecko based web browser";
      homepage = "https://zen-browser.app/";
      license = licenses.mpl20;
      platforms = platforms.darwin;
      maintainers = [ ];
    };
  };
in
{
  home-manager.users.${user} = { ... }: {
    home.packages = [ zen-browser ];
  };
}