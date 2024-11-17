{ root, config, pkgs, ... }:

let
  xdg_home = config.home.homeDirectory;
  # xdg_configHome = "${xdg_home}/.config";
  # xdg_dataHome   = "${xdg_home}/.local/share";
  # xdg_stateHome  = "${xdg_home}/.local/state";
  shared = import ../../shared/files/default.nix { inherit config pkgs root; };
in
shared //
{
  "${xdg_home}/.amethyst.yml".source = ./amethyst.yml;
}
