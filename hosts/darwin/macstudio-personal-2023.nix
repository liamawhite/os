{ pkgs, mac-app-util, ... }:

let
  user = "liam";
  machine = "macstudio-personal-2023";
  home = "/Users/${user}";
  root = "${home}/github.com/liamawhite/os";

  modules = path: args: if args == null then ../../modules + path else import (../../modules + path) args;
in
{
  imports = [
    # Common configuration for all machines
    (modules /nix.nix { inherit user pkgs; buildId = 350; })
    (modules /nixpkgs.nix null)
    (modules /fonts.nix { inherit pkgs; })

    # Darwin-specific configuration
    (modules /darwin/settings.nix { inherit user machine; stateVersion = 5; })
    (modules /darwin/user.nix { inherit user pkgs home; })
    (modules /darwin/home-manager.nix { inherit user mac-app-util; stateVersion = "23.11"; })

    # Development
    (modules /programs/development/cloud.nix { inherit user pkgs; })
    (modules /programs/development/ides.nix { inherit user pkgs; })
    (modules /programs/development/agents.nix { inherit user pkgs; })

    # Terminal and Dotfiles
    (modules /programs/terminal/darwin.nix { inherit user pkgs; })
    (modules /dotfiles/default.nix { inherit user pkgs root; })

    # GUI Applications
    (modules /programs/1password/darwin.nix null)
    (modules /programs/aerospace/darwin.nix { inherit user pkgs; })
    (modules /programs/obsidian/default.nix { inherit user pkgs; })
    (modules /programs/browsers/chrome/default.nix { inherit user pkgs; })
    (modules /programs/browsers/zen/darwin.nix { inherit user pkgs; })
  ];
}

