{ root, config, pkgs, ... }:

let
  xdg_home = config.home.homeDirectory;
  xdg_configHome = "${xdg_home}/.config";
  # xdg_dataHome   = "${xdg_home}/.local/share";
  # xdg_stateHome  = "${xdg_home}/.local/state";
  zsh-autosuggestions = pkgs.callPackage ../packages/zsh-autosuggestions.nix { };

  # Symlinks to a place in this repo so we can edit them without rebuilding the system
  useLocal = rel: config.lib.file.mkOutOfStoreSymlink "${root}/modules/shared/files/${rel}";
in
{
  "${xdg_configHome}/starship.toml".source = useLocal "starship.toml";
  "${xdg_configHome}/wezterm".source = useLocal "wezterm";
  "${xdg_configHome}/nvim".source = useLocal "nvim";
  "${xdg_home}/.zshrc".source = useLocal "zshrc";
  "${xdg_home}/.zsh".source = useLocal "zsh";
  "${xdg_home}/bin".source = useLocal "bin";

  "${xdg_home}/.ssh" = { source = ./ssh; recursive = true; };
  "${xdg_home}/.zshplugins/zsh-autosuggestions.zsh" = { source = "${zsh-autosuggestions}/zsh/zsh-autosuggestions.zsh"; };
}
