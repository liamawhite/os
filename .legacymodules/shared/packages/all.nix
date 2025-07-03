{ pkgs }:

with pkgs; [
  # Consumer Applications
  slack
  spotify
  discord
  ookla-speedtest
  home-assistant-cli

  # Encryption and security tools
  # The 1password gui can't be installed here as it needs to be ran from /Applications
  _1password-cli
  age
  ssh-to-age
  sops
]

