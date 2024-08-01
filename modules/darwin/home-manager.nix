{ config, pkgs, lib, home-manager, ... }:

let
  user = "liam";
  additionalFiles = import ./files.nix { inherit user config pkgs; };
  sharedFiles = import ../shared/files.nix { inherit user config pkgs; };
in
{
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;

    # Pulumi was misbehaving with nixpkgs, so I'm using homebrew for it
    brews = [
      "pulumi/homebrew-tap/pulumi"
      "pulumi/homebrew-tap/crd2pulumi"
      "pulumi/homebrew-tap/esc"
      "dagger/homebrew-tap/dagger"
    ];
    # Taps are declarative via nix-homebrew
    taps = [ ];

    casks = pkgs.callPackage ./homebrew/casks.nix { };

    # These app IDs are from using the mas CLI app
    # $ mas search <app name>
    masApps = {
      "Amazon Kindle" = 302584613;
      "Logic Pro" = 634148309;
      "NordVPN: VPN Fast & Secure" = 905953485;
      "Tailscale" = 1475387142;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }: {
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix { };
        file = lib.mkMerge [
          additionalFiles
          sharedFiles
        ];
        stateVersion = "23.11";
      };
      programs = { } // import ../shared/home-manager.nix { inherit config pkgs lib; };

      services = {
        # TODO: https://github.com/nix-community/home-manager/issues/4049
        syncthing = {
          enable = true;
        };
      };

      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      manual.manpages.enable = false;
    };
  };
}
