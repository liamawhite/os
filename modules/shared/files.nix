{ user, config, pkgs, ... }:

let
  xdg_home = config.users.users.${user}.home;
  xdg_configHome = "${config.users.users.${user}.home}/.config";
  xdg_dataHome   = "${config.users.users.${user}.home}/.local/share";
  xdg_stateHome  = "${config.users.users.${user}.home}/.local/state"; in
{
  "${xdg_configHome}/starship.toml".source = ./files/starship.toml;
  "${xdg_configHome}/wezterm" = { source = ./files/wezterm; recursive = true; };
}
