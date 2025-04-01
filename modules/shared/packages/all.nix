{ pkgs }:

with pkgs; [
  # Consumer Applications
  slack
  spotify
  obsidian
  discord
  ookla-speedtest
  home-assistant-cli

  # General packages for development and system management
  aspell
  aspellDicts.en
  coreutils
  code-cursor
  buf
  gh
  # ghostty
  licenser
  neofetch
  neovim
  protoc-gen-connect-go
  protoc-gen-go
  sqlite
  #syncthing
  vscode
  wezterm

  # Languages

  ## Golang
  go
  golangci-lint
  gopls
  gotools
  delve
  cobra-cli

  ## Python
  python3
  pyright
  python312Packages.pip
  mypy
  ruff
  poetry
  black

  ## Rust
  rustc
  cargo
  rustfmt
  rust-analyzer

  ## JS/TS
  tailwindcss-language-server
  nodePackages.typescript-language-server
  vscode-langservers-extracted # markdown html css json eslin (not all are used)
  yarn-berry
  yaml-language-server

  ## Misc
  nodePackages.bash-language-server
  jdk23 # latest LTS
  lua-language-server
  luarocks
  nodejs_20 # latest LTS
  nil
  nixpkgs-fmt
  elixir

  # Encryption and security tools
  # The 1password gui can't be installed here as it needs to be ran from /Applications
  _1password-cli
  age
  ssh-to-age
  sops
  tailscale

  # Cloud-related tools and SDKs
  act
  azure-cli
  awscli2
  cmctl
  fluxcd
  google-cloud-sdk
  kubernetes-helm
  kubectl
  k9s
  istioctl
  podman
  qemu # required for podman
  skopeo
  terraform
  vcluster

  # Text and terminal utilities
  bash-completion
  bat
  bottom
  btop
  cht-sh
  du-dust
  htop
  iftop
  jq
  yq-go
  eza
  fabric-ai
  flock
  fzf
  gitmux
  grpcurl
  inetutils
  lazygit
  nmap
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
  asciinema
  ffmpeg
  fd
  ttyd
  vhs

  # Local ones that weren't in nixpkgs
  (import ./crd2pulumi.nix { inherit pkgs; })
  (import ./gow.nix { inherit pkgs; })
  (import ./rapture.nix { inherit pkgs; })
  (import ./temporal.nix { inherit pkgs; })
  (import ./vaulted.nix { inherit pkgs; })
  (import ./zsh-autosuggestions.nix { inherit pkgs; })
]

