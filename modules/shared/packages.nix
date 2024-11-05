{ pkgs }:

with pkgs; [
  # Consumer Applications
  slack
  spotify
  obsidian
  discord
  ookla-speedtest

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
  #syncthing
  vscode
  wezterm

  # Languages
  nodePackages.bash-language-server
  buf-language-server
  delve
  go
  golangci-lint
  gopls
  gotools
  cobra-cli
  lua-language-server
  nodejs_20 # latest LTS
  rustc
  cargo
  nil
  nixpkgs-fmt  
  rustfmt
  rust-analyzer
  tailwindcss-language-server
  nodePackages.typescript-language-server
  vscode-langservers-extracted # markdown html css json eslin (not all are used)
  yarn-berry
  yaml-language-server
  jdk23 # latest LTS

  # Encryption and security tools
  # The 1password gui can't be installed here as it needs to be ran from /Applications
  _1password-cli
  tailscale

  # Cloud-related tools and SDKs
  act
  azure-cli
  awscli2
  cmctl
  # docker needs to be installed on linux only as it's included in the docker-desktop on mac
  # docker-compose
  google-cloud-sdk
  kubectl
  k9s
  istioctl
  podman
  qemu # required for podman
  terraform
  kubernetes-helm

  # Text and terminal utilities
  bash-completion
  bat
  bottom
  cht-sh
  du-dust
  htop
  iftop
  jq
  eza
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
  zoxide

  # Media-related packages
  ffmpeg
  fd

  # Local ones that weren't in nixpkgs
  (import ../../packages/crd2pulumi.nix { inherit pkgs; })
  (import ../../packages/gow.nix { inherit pkgs; })
  (import ../../packages/licenser.nix { inherit pkgs; })
  (import ../../packages/rapture.nix { inherit pkgs; })
  (import ../../packages/temporal.nix { inherit pkgs; })
  (import ../../packages/vaulted.nix { inherit pkgs; })
]
