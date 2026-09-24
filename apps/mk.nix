{ self, nixpkgs, email }:

scriptName: system: {
  type = "app";
  program = "${(nixpkgs.legacyPackages.${system}.writeScriptBin scriptName ''
    #!/usr/bin/env bash
    export EMAIL=${email}
    # Keep git-crypt on the same GnuPG installation as Home Manager.
    export PATH=${nixpkgs.lib.makeBinPath [ nixpkgs.legacyPackages.${system}.git nixpkgs.legacyPackages.${system}.gnupg ]}:$PATH
    echo "Running ${scriptName} for ${system}"
    exec ${self}/apps/${system}/${scriptName}
  '')}/bin/${scriptName}";
}
