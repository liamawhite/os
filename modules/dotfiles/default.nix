{ user, root, pkgs, ... }:

{
  home-manager.users.${user} = { config, lib, ... }:
    let
      xdg_home = config.home.homeDirectory;
      xdg_configHome = "${xdg_home}/.config";
      zsh-autosuggestions = pkgs.callPackage ./zsh-autosuggestions.nix { };

      # Symlinks to a place in this repo so we can edit them without rebuilding the system
      useLocal = rel: config.lib.file.mkOutOfStoreSymlink "${root}/modules/dotfiles/${rel}";
    in
    {
      home.file = {
        "${xdg_configHome}/starship.toml".source = useLocal "starship.toml";
        "${xdg_configHome}/wezterm".source = useLocal "wezterm";
        "${xdg_configHome}/nvim".source = useLocal "nvim";
        "${xdg_configHome}/ghostty".source = useLocal "ghostty";
        "${xdg_home}/.zshrc".source = useLocal "zshrc";
        "${xdg_home}/.zsh".source = useLocal "zsh";
        "${xdg_home}/bin".source = useLocal "bin";
        "${xdg_home}/.claude/settings.json".source = useLocal "claude/settings.json";
        "${xdg_home}/.aerospace.toml".source = useLocal "aerospace.toml";
        "${xdg_home}/.ssh" = { source = ./ssh; recursive = true; };
        "${xdg_home}/.zshplugins/zsh-autosuggestions.zsh" = { source = "${zsh-autosuggestions}/zsh/zsh-autosuggestions.zsh"; };
      };
    };
}
