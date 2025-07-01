{ user, mac-app-util, stateVersion, packages, root, pkgs }:

{
    useGlobalPkgs = true;
    sharedModules = [ mac-app-util.homeManagerModules.default ];

    users.${user} = { config, lib, ... }: {
      home = {
        inherit stateVersion packages;
        file = import ../dotfiles/default.nix { inherit user config pkgs root; };
        enableNixpkgsReleaseCheck = false;
      };
    };
}