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
      darwinSystems = [ "aarch64-darwin" ];
      darwinApps = import ./apps/darwin.nix { inherit self nixpkgs email; };
      linuxSystems = [ "aarch64-linux" ];
      linuxApps = import ./apps/linux.nix { inherit self nixpkgs email; };
    in
    {
      apps = nixpkgs.lib.genAttrs darwinSystems darwinApps // nixpkgs.lib.genAttrs linuxSystems linuxApps;

      # MacOS Machines
      darwinConfigurations = {
        # All my laptops/desktops are running on ARM based Apple Silicon and are identical by design
        macos = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = inputs // { inherit user email; };
          modules = [
            mac-app-util.darwinModules.default
            home-manager.darwinModules.home-manager
            ./overlays
            ./hosts/darwin
          ];
        };
      };

      # Linux Machines (non-NixOS)
      homeConfigurations = {
        # Its quite convuluted to get NixOS running on a Raspberry Pi 5, so I'm just using Nix to manage PiOS
        pios = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-linux;
          modules = [
            ./hosts/pios
          ];
        };
      };
    };
}
