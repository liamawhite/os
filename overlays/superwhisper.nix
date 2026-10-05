{ lib, stdenvNoCC, src }:

let
  # Flake archive inputs strip the enclosing superwhisper.app directory.
  infoPlist = builtins.readFile "${src}/Contents/Info.plist";
  versionMatch = builtins.match ".*<key>CFBundleShortVersionString</key>[[:space:]]*<string>([^<]+)</string>.*" infoPlist;
in
stdenvNoCC.mkDerivation {
  pname = "superwhisper";
  version = builtins.head versionMatch;
  inherit src;

  dontUnpack = true;
  # Preserve the vendor's code signature by leaving the bundle unchanged.
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/Applications/superwhisper.app"
    cp -R "$src"/. "$out/Applications/superwhisper.app/"
    runHook postInstall
  '';

  meta = with lib; {
    description = "On-device voice dictation for macOS";
    homepage = "https://superwhisper.com/";
    license = licenses.unfree;
    platforms = platforms.darwin;
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
  };
}
