{ user, pkgs }:

{
  home-manager.users.${user} = { config, lib, ... }: {
    home.activation = {
      installTodoist = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        # Install Todoist from Mac App Store if not already installed
        if ! ${pkgs.mas}/bin/mas list | grep -q "585829637"; then
          echo "Installing Todoist..."
          ${pkgs.mas}/bin/mas install 585829637
        fi
      '';
      installFantastical = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        # Install Fantastical from Mac App Store if not already installed
        if ! ${pkgs.mas}/bin/mas list | grep -q "975937182"; then
          echo "Installing Fantastical..."
          ${pkgs.mas}/bin/mas install 975937182
        fi
      '';
    };
  };
}
