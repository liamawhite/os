{ pkgs }:

with pkgs; [
  # Consumer Applications
  slack
  spotify
  obsidian
  discord

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
  cobra-cli
  nodejs_20 # latest LTS
  rustc
  cargo
  rustfmt
  yarn-berry
  jdk20 # latest LTS

  # Encryption and security tools
  # The 1password gui can't be installed here as it needs to be ran from /Applications
  _1password

  # Cloud-related tools and SDKs
  act
  azure-cli
  awscli2
  docker
  docker-compose
  google-cloud-sdk
  kubectl
  k9s

  # Text and terminal utilities
  bash-completion
  bat
  bottom
  htop
  iftop
  jq
  flock
  fzf
  grpcurl
  lazygit
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

  # Local ones that weren't in nixpkgs
  (import ../../packages/rapture.nix { inherit pkgs; })
  (import ../../packages/temporal.nix { inherit pkgs; })
  (import ../../packages/vaulted.nix { inherit pkgs; })
]
