{ user, config, pkgs, ... }:

let
  xdg_home = config.users.users.${user}.home;
  xdg_configHome = "${config.users.users.${user}.home}/.config";
  xdg_dataHome   = "${config.users.users.${user}.home}/.local/share";
  xdg_stateHome  = "${config.users.users.${user}.home}/.local/state";
  zsh-autosuggestions = pkgs.callPackage ./../../packages/zsh-autosuggestions.nix {};
in
{
  "${xdg_configHome}/starship.toml".source = ./files/starship.toml;
  "${xdg_configHome}/wezterm" = { source = ./files/wezterm; recursive = true; };
  "${xdg_configHome}/nvim" = { source = ./files/nvim; recursive = true; };
  "${xdg_home}/bin" = { source = ./files/bin; recursive = true; executable = true; };
  "${xdg_home}/.tmux" = { source = ./files/tmux; recursive = true; executable = true; };
  "${xdg_home}/.ssh" = { source = ./files/ssh; recursive = true; };
  "${xdg_home}/.zshrc" = { source = ./files/zshrc; };
  "${xdg_home}/.zsh" = { source = ./files/zsh; recursive = true; executable = true; };
  "${xdg_home}/.zsh/zsh-autosuggestions.zsh" = { source = "${zsh-autosuggestions}/zsh/zsh-autosuggestions.zsh"; };
}
