{ user, pkgs, ... }:

{
  imports = [
    (import ./default.nix { inherit user pkgs; })
  ];

  home-manager.users.${user} = { ... }: {
    home.packages = with pkgs; [
      # GNU fixes for macOS
      gnused # Fix macOS sed and grep
      gnugrep # Fix macOS sed and grep
    ];
  };
}