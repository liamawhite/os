{ pkgs, system, mac-app-util, user, email, ... }:

let
  home = "/Users/${user}";
  root = "${home}/github.com/liamawhite/os";
in
{
  users.users.${user} = {
    inherit home;
    name = "${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = import ./homebrew.nix;

  home-manager = {
    useGlobalPkgs = true;
    sharedModules = [ mac-app-util.homeManagerModules.default ];
    users.${user} = { pkgs, config, lib, ... }: {
      home = {
        enableNixpkgsReleaseCheck = false;
        file = import ./files/default.nix { inherit user config pkgs root; };
        packages = import ./packages.nix { inherit pkgs system; };
        stateVersion = "23.11";
      };

      programs = import ./programs.nix { inherit pkgs config lib user email; };

      services = {
        # TODO: https://github.com/nix-community/home-manager/issues/4049
        syncthing = {
          enable = true;
        };
      };
    };
  };
}
