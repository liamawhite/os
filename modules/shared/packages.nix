{ pkgs }:

with pkgs; [
  # General packages for development and system management
  # act
  # aspell
  # aspellDicts.en
  bash-completion
  bat
  # btop
  coreutils
  killall
  # neofetch
  openssh
  # pandoc
  sqlite
  wezterm
  wget
  zip

  # Encryption and security tools
  _1password-gui
  _1password #cli
  # age
  # age-plugin-yubikey
  # gnupg
  # libfido2
  # pinentry
  # yubikey-manager

  # Cloud-related tools and SDKs
  docker
  docker-compose

  awscli2
  # flyctl
  # ngrok
  tflint

  # Media-related packages
  ffmpeg
  fd

  # Text and terminal utilities
  # htop
  # hunspell
  # iftop
  # jetbrains-mono
  jq
  ripgrep
  tree
  tmux
  unrar
  unzip
]
