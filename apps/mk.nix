{ self, nixpkgs, email }:

scriptName: system: {
  type = "app";
  program = "${(nixpkgs.legacyPackages.${system}.writeScriptBin scriptName ''
    #!/usr/bin/env bash
    export EMAIL=${email}
    PATH=${nixpkgs.legacyPackages.${system}.git}/bin:$PATH
    echo "Running ${scriptName} for ${system}"
    exec ${self}/apps/${system}/${scriptName}
  '')}/bin/${scriptName}";
}

