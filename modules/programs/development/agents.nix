{ user, pkgs }:

{
  home-manager.users.${user} = { config, lib, ... }: {
    home = {
      packages = [
        pkgs.claude-code
        pkgs.gh-copilot
        pkgs.codex
      ];
    };
  };
}
