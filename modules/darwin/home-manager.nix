{ user, mac-app-util, stateVersion }:

{
  home-manager = {
    useGlobalPkgs = true;
    sharedModules = [ mac-app-util.homeManagerModules.default ];

    users.${user} = { config, lib, pkgs, ... }: {
      home = {
        inherit stateVersion;
        enableNixpkgsReleaseCheck = false;
        packages = [
          pkgs.mas
        ];
      };
    };
  };
}

