{ user, pkgs, ... }:

let
  msf-cli = pkgs.stdenv.mkDerivation rec {
    pname = "msf-cli";
    version = "3.9.6";

    platform =
      if pkgs.stdenv.isDarwin then
        if pkgs.stdenv.hostPlatform.isAarch64 then "macos-arm64"
        else "macos-amd64"
      else "linux-amd64";

    artifactName = "msf-cli-${platform}-${version}.zip";

    src = pkgs.fetchurl {
      url = "https://artifactory.docusigntest.com/artifactory/github-releases-local/msf-cli/${version}/${artifactName}";
      sha256 = "sha256-QmMC2zgxP+bLyh+N1g2+QLt/t4M29GqNeMMBVOMwI5Q=";
    };

    nativeBuildInputs = [ pkgs.unzip ];

    phases = [ "unpackPhase" "installPhase" ];

    unpackPhase = ''
      mkdir -p $out/lib
      unzip -qo $src -d $out/lib/msf-cli
    '';

    installPhase = ''
      mkdir -p $out/bin
      chmod +x $out/lib/msf-cli/msf-cli/msf-cli
      ln -sf $out/lib/msf-cli/msf-cli/msf-cli $out/bin/msf-cli
    '';
  };
in
{
  home-manager.users.${user} = { ... }: {
    home.packages = [
      msf-cli
    ];
  };
}

