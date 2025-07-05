{ user, pkgs }:

{
  home-manager.users.${user} = { config, lib, ... }: {
    home = {
      packages = [
        pkgs.ollama
      ];
    };
  };
}