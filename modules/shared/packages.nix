{ pkgs }:

with pkgs; [
  # General packages for development and system management
  act
  aspell
  aspellDicts.en
  bash-completion
  bat
  bottom
  coreutils
  neofetch
  neovim
  openssh
  sqlite
  starship
  wezterm
  wget
  zip

  # Languages
  go
  nodejs_20 # latest LTS
  rustc
  yarn-berry

  # Encryption and security tools
  _1password-gui
  _1password #cli

  # Cloud-related tools and SDKs
  azure-cli
  awscli2
  crd2pulumi
  docker
  docker-compose
  google-cloud-sdk
  kubectl
  k9s
  pulumi

  # Text and terminal utilities
  htop
  iftop
  jq
  fzf
  ripgrep
  tree
  tmux
  unrar
  unzip

  # Media-related packages
  ffmpeg
  fd
]
