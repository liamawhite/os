{ pkgs, ... }:

let
  user = "pios";
  home = "/home/${user}";
in
{
  home = {
    username = user;
    homeDirectory = home;
    stateVersion = "23.11";
    packages = [
      pkgs.git
      pkgs.k3s
    ];
  };
  programs = {
    home-manager.enable = true;
  };
}
