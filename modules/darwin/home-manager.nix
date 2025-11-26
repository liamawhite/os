{ user, stateVersion }:

{
  home-manager = {
    useGlobalPkgs = true;

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

