{ pkgs }:

with pkgs; [
  # Consumer Applications
  slack
  spotify
  obsidian

  # General packages for development and system management
  aspell
  aspellDicts.en
  coreutils
  gh
  neofetch
  neovim
  sqlite
  syncthing
  wezterm

  # Languages
  go
  nodejs_20 # latest LTS
  rustc
  yarn-berry

  # Encryption and security tools
  # The 1password gui can't be installed here as it needs to be ran from /Applications
  _1password

  # Cloud-related tools and SDKs
  act
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
  bash-completion
  bat
  bottom
  htop
  iftop
  jq
  fzf
  openssh
  ripgrep
  starship
  tree
  tmux
  unrar
  unzip
  wget
  zip

  # Media-related packages
  ffmpeg
  fd
]
