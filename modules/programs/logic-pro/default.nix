{ user, pkgs }:

{
  home-manager.users.${user} = { config, lib, ... }: {
    home.activation = {
      installLogicPro = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        # Install Logic Pro from Mac App Store if not already installed
        if ! ${pkgs.mas}/bin/mas list | grep -q "634148309"; then
          echo "Installing Logic Pro..."
          ${pkgs.mas}/bin/mas install 634148309
        fi
      '';
    };
  };
}