{
  enable = true;
  onActivation = {
    # Automatically update Homebrew and all formulae
    autoUpdate = true;

    # Automatically upgrade outdated formulae and Mac App Store apps
    upgrade = true;

    # Uninstalls all formulae not listed in the generated Brewfile, and if the
    # formula is a cask, removes all files associated with that cask
    cleanup = "zap";
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
    "borders"
  ];

  casks = [
    # System Tools
    "nikitabobko/tap/aerospace"
    "docker" # docker for mac is required on macOS
    "ghostty"
    "raspberry-pi-imager"
    "balenaetcher"
    "karabiner-elements"

    # Consumer Applications
    "chatgpt"
    "elgato-stream-deck"
    "zen"
    "firefox" # for some reason the pkg doesn't work on macOS
    "google-chrome"
    "obs"
    "steam"
    "vlc"

    # Security
    # 1password gui is available in nixpkgs but it has to be ran from /Applications
    "1password"

    # AI
    "diffusionbee"
    "ollama"
  ];

  # These app IDs are from using the mas CLI app
  # $ mas search <app name>
  masApps = {
    "Amazon Kindle" = 302584613;
    "Logic Pro" = 634148309;
    "Tailscale" = 1475387142;
  };
}

