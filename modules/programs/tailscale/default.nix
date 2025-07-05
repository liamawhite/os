{ user, pkgs }:

{
  home-manager.users.${user} = { config, lib, ... }: {
    home.activation = {
      installTailscale = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        # Install Tailscale from Mac App Store if not already installed
        if ! ${pkgs.mas}/bin/mas list | grep -q "1475387142"; then
          echo "Installing Tailscale..."
          ${pkgs.mas}/bin/mas install 1475387142
        fi
      '';
    };
  };
}