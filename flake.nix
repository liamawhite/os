{
  description = "Configuration for my personal machines";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    darwin = { url = "github:LnL7/nix-darwin/master"; inputs.nixpkgs.follows = "nixpkgs"; };
    disko = { url = "github:nix-community/disko"; inputs.nixpkgs.follows = "nixpkgs"; };
    mac-app-util = { url = "github:hraban/mac-app-util"; inputs.nixpkgs.follows = "nixpkgs"; }; # Fixes spotlight loading
    licenser = { url = "github:liamawhite/licenser"; inputs.nixpkgs.follows = "nixpkgs"; };
  };
  outputs = { self, darwin, home-manager, nixpkgs, disko, mac-app-util, licenser }@inputs:
    let
      user = "liam";
      email = "liamawhite@gmail.com";
      darwinSystems = [ "aarch64-darwin" "x86_64-darwin" ];
      darwinApps = import ./apps/darwin.nix { inherit self nixpkgs email; };
    in
    {
      apps = nixpkgs.lib.genAttrs darwinSystems darwinApps; # // nixpkgs.lib.genAttrs linuxSystems linuxApps;

      darwinConfigurations = {
        macbookpro-docusign-2025 = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = inputs // { inherit user email; };
          modules = [
            mac-app-util.darwinModules.default
            home-manager.darwinModules.home-manager
            ./overlays
            ./hosts/darwin/macbookpro-docusign-2025.nix
          ];
        };
        macstudio-personal-2023 = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = inputs // { inherit user email; };
          modules = [
            mac-app-util.darwinModules.default
            home-manager.darwinModules.home-manager
            ./overlays
            ./hosts/darwin/macstudio-personal-2023.nix
          ];
        };
        macbookpro-personal-2018 = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          specialArgs = inputs // { inherit user email; };
          modules = [
            mac-app-util.darwinModules.default
            home-manager.darwinModules.home-manager
            ./overlays
            ./hosts/darwin/macbookpro-personal-2018.nix
          ];
        };
        macbookpro-personal-2025 = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = inputs // { inherit user email; };
          modules = [
            mac-app-util.darwinModules.default
            home-manager.darwinModules.home-manager
            ./overlays
            ./hosts/darwin/macbookpro-personal-2025.nix
          ];
        };
      };
    };
}
