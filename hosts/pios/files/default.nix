{ pkgs, config, ... }:

let
  xdg_home = config.home.homeDirectory;
in
{
    "${xdg_home}/bin".source = ./bin;
}

