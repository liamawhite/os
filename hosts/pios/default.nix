{ pkgs, config, ... }:

let
  user = "pios";
  home = "/home/${user}";
in
{
  home = {
    username = user;
    homeDirectory = home;
    stateVersion = "23.11";
    file = import ./files/default.nix { inherit pkgs config; };
    packages = import ./packages.nix { inherit pkgs; };
  };
  programs = {
    home-manager.enable = true;
  };
  targets.genericLinux.enable = true;
}
