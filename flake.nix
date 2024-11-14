{
  description = "Configuration for my personal machines";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    darwin = { url = "github:LnL7/nix-darwin/master"; inputs.nixpkgs.follows = "nixpkgs"; };
    disko = { url = "github:nix-community/disko"; inputs.nixpkgs.follows = "nixpkgs"; };
    mac-app-util = { url = "github:hraban/mac-app-util"; inputs.nixpkgs.follows = "nixpkgs"; }; # Fixes spotlight loading
    licenser = { url = "github:liamawhite/licenser/bdf2c1beeaf09aae9f27b9d680b5b6aa22e4f1a0"; inputs.nixpkgs.follows = "nixpkgs"; };
  };
  outputs = { self, darwin, home-manager, nixpkgs, disko, mac-app-util, licenser }@inputs:
    let
      email = "liamawhite@gmail.com";
      darwinSystems = [ "aarch64-darwin" ];
      linuxSystems = [ ];
      forAllSystems = f: nixpkgs.lib.genAttrs (darwinSystems) f;
      mkApp = scriptName: system: {
        type = "app";
        program = "${(nixpkgs.legacyPackages.${system}.writeScriptBin scriptName ''
          #!/usr/bin/env bash
          export EMAIL=${email}
          PATH=${nixpkgs.legacyPackages.${system}.git}/bin:$PATH
          echo "Running ${scriptName} for ${system}"
          exec ${self}/scripts/${system}/${scriptName}
        '')}/bin/${scriptName}";
      };
      mkDarwinApps = system: {
        "build-switch" = mkApp "build-switch" system;
      };
    in
    {
      apps = nixpkgs.lib.genAttrs darwinSystems mkDarwinApps;

      darwinConfigurations = {
        macos = darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          specialArgs = inputs // { inherit system; };
          modules = [
            mac-app-util.darwinModules.default
            home-manager.darwinModules.home-manager
            ./hosts/darwin
          ];
        };
      };
    };
}
