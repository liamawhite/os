{
  description = "Configuration for MacOS and NixOS";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-pulumi = {
      url = "github:pulumi/homebrew-tap";
      flake = false;
    };
    homebrew-dagger = {
      url = "github:dagger/homebrew-tap";
      flake = false;
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Fixes spotlight loading
    mac-app-util.url = "github:hraban/mac-app-util";
  };
  outputs = { self, darwin, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, homebrew-pulumi, homebrew-dagger, home-manager, nixpkgs, disko, mac-app-util } @inputs:
    let
      email = "liamawhite@gmail.com";
      darwinSystems = [ "aarch64-darwin" ];
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
        macos = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = inputs;
          modules = [
            nix-homebrew.darwinModules.nix-homebrew
            mac-app-util.darwinModules.default
            home-manager.darwinModules.home-manager
            ./hosts/darwin
          ];
        };
      };
  };
}
