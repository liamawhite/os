{ user, pkgs, ... }:

{
  home-manager.users.${user} = { ... }: {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}

