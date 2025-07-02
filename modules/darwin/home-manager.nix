{ user, mac-app-util, stateVersion, packages, programs, root, pkgs }:

{
  useGlobalPkgs = true;
  sharedModules = [ mac-app-util.homeManagerModules.default ];

  users.${user} = { config, lib, ... }: {
    inherit programs;
    home = {
      inherit stateVersion packages;
      file = import ../dotfiles/default.nix { inherit user config pkgs root; };
      enableNixpkgsReleaseCheck = false;
    };
  };
}

