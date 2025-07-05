{ user, pkgs }:

{
  home-manager.users.${user} = { config, lib, ... }: {
    home.activation = {
      installFinalCutPro = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        # Install Final Cut Pro from Mac App Store if not already installed
        if ! ${pkgs.mas}/bin/mas list | grep -q "424389933"; then
          echo "Installing Final Cut Pro..."
          ${pkgs.mas}/bin/mas install 424389933
        fi
      '';
    };
  };
}