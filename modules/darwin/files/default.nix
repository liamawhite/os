{ user, config, pkgs, ... }:

let
  xdg_home = config.users.users.${user}.home;
  # xdg_configHome = "${config.users.users.${user}.home}/.config";
  xdg_dataHome = "${config.users.users.${user}.home}/.local/share";
  # xdg_stateHome = "${config.users.users.${user}.home}/.local/state";
  shared = import ../../shared/files/default.nix { inherit user config pkgs; };
in
shared //
{
  "${xdg_home}/.amethyst.yml".source = ./amethyst.yml;

  # Raycast script so that "Run Emacs" is available and uses Emacs daemon
  # TODO use this pattern for other things
  "${xdg_dataHome}/bin/emacsclient" = {
    executable = true;
    text = ''
      #!/bin/zsh
      #
      # Required parameters:
      # @raycast.schemaVersion 1
      # @raycast.title Run Emacs
      # @raycast.mode silent
      #
      # Optional parameters:
      # @raycast.packageName Emacs
      # @raycast.icon ${xdg_dataHome}/img/icons/Emacs.icns
      # @raycast.iconDark ${xdg_dataHome}/img/icons/Emacs.icns

      if [[ $1 = "-t" ]]; then
        # Terminal mode
        ${pkgs.emacs}/bin/emacsclient -t $@
      else
        # GUI mode
        ${pkgs.emacs}/bin/emacsclient -c -n $@
      fi
    '';
  };
}
