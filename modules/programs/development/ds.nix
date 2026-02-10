{ user, pkgs, ... }:

let
  msf-cli = pkgs.stdenv.mkDerivation rec {
    pname = "msf-cli";
    version = "1.9.3";

    platform =
      if pkgs.stdenv.isDarwin then
        if pkgs.stdenv.hostPlatform.isAarch64 then "macos-arm64"
        else "macos-amd64"
      else "linux-amd64";

    artifactName = "msf-cli-${platform}-${version}.zip";

    src = pkgs.fetchurl {
      url = "https://artifactory.docusigntest.com/artifactory/github-releases-local/msf-cli/${version}/${artifactName}";
      sha256 = "sha256-gbnK2UxrkKKAa2Mbm4xqCeW8ySEk9gh3zKTuVSDYC3w=";
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

