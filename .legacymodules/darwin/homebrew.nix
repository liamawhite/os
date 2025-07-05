{
  enable = true;
  onActivation = {
    # Automatically update Homebrew and all formulae
    autoUpdate = true;

    # Automatically upgrade outdated formulae and Mac App Store apps
    upgrade = true;

    # Uninstalls all formulae not listed in the generated Brewfile, and if the
    # formula is a cask, removes all files associated with that cask
    # cleanup = "zap"; # TODO: re-enable this when brew doesn't keep uninstalling casks that are in the Brewfile
  };

  taps = [
    "pulumi/tap"
    "dagger/tap"
    "nikitabobko/tap"
    "FelixKratz/formulae"
  ];

  # Pulumi was misbehaving with nixpkgs, so I'm using homebrew for it
  brews = [
    "pulumi/homebrew-tap/pulumi"
    "pulumi/homebrew-tap/esc"
    "dagger/homebrew-tap/dagger"
  ];

  casks = [
    # System Tools
    "docker" # docker for mac is required on macOS
    "ghostty"

    # Consumer Applications
    "chatgpt"
    "elgato-stream-deck"
    "obs"
    "vlc"

    # AI
    "claude"
  ];

  # These app IDs are from using the mas CLI app
  # $ mas search <app name>
  masApps = {
    "Amazon Kindle" = 302584613;
    "Logic Pro" = 634148309;
    "Tailscale" = 1475387142;
  };
}

