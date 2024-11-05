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

  # Bootstrap machine with homebrew and xcode-select
  system.activationScripts.preUserActivation.text = ''
    if ! xcode-select --version 2>/dev/null; then
      xcode-select --install
    fi
    if ! /opt/homebrew/bin/brew --version 2>/dev/null; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  '';

  homebrew = {
    enable = true;
    onActivation = {
      # Uninstalls all formulae not listed in the generated Brewfile, and if the
      # formula is a cask, removes all files associated with that cask
      cleanup = "zap";

      # Automatically upgrade outdated formulae and Mac App Store apps
      upgrade = true;
    };

    taps = [
      "homebrew/bundle"
      "pulumi/tap"
      "dagger/tap"
    ];

    # Pulumi was misbehaving with nixpkgs, so I'm using homebrew for it
    brews = [
      "pulumi/homebrew-tap/pulumi"
      "pulumi/homebrew-tap/esc"
      "dagger/homebrew-tap/dagger"
    ];

    casks = [
      # System Tools
      "amethyst"
      "docker" # docker for mac is required on macOS

      # Consumer Applications
      "elgato-stream-deck"
      "firefox" # for some reason the pkg doesn't work on macOS
      "google-chrome"
      "obs"
      "vivaldi"
      "vlc"

      # Security
      # 1password gui is available in nixpkgs but it has to be ran from /Applications
      "1password"

      # AI
      "diffusionbee"
    ];

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
    };
  };
}
