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
  buf
  gh
  neofetch
  neovim
  protoc-gen-connect-go
  protoc-gen-go
  sqlite
  syncthing
  wezterm

  # Languages
  go
  golangci-lint
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
  gitmux
  grpcurl
  lazygit
  openssh
  ripgrep
  starship
  tmux
  tree
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
