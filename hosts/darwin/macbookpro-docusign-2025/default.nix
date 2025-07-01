{ pkgs, lib, mac-app-util, ... }:

let
  user = "liam.white";
  machine = "DSAF2J3Q36DQG";
  home = "/Users/${user}";
  root = "${home}/github.com/liamawhite/os";
in
{
  nix = import ../nix.nix { inherit user pkgs; };
  nixpkgs = import ../nixpkgs.nix;
  fonts = import ../fonts.nix { inherit pkgs; };
  users = import ../../../modules/darwin/user.nix { inherit user pkgs; };
  system = lib.mkMerge [
    (import ../system.nix { inherit user; })
    {
      stateVersion = 5;
    }
  ];
  home-manager = import ../../../modules/darwin/home-manager.nix {
    inherit user mac-app-util root pkgs;
    stateVersion = "23.11";
    packages = lib.unique (
      import ../../../modules/packages/gnufixes.nix { inherit pkgs; }
      ++ import ../../../modules/packages/aerospace.nix { inherit pkgs; }
      ++ import ../../../modules/packages/terminal.nix { inherit pkgs; }
      ++ import ../../../modules/packages/cloud.nix { inherit pkgs; }
      ++ import ../../../modules/packages/ides.nix { inherit pkgs; }
    );
  };


  # Host-specific configuration
  ids.gids.nixbld = 350;
  networking.computerName = machine;
  networking.hostName = machine;
}

