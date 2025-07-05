{ user, pkgs }:

{
  home-manager.users.${user} = { config, lib, ... }: {
    home.activation = {
      installKindle = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        # Install Amazon Kindle from Mac App Store if not already installed
        if ! ${pkgs.mas}/bin/mas list | grep -q "302584613"; then
          echo "Installing Amazon Kindle..."
          ${pkgs.mas}/bin/mas install 302584613
        fi
      '';
    };
  };
}