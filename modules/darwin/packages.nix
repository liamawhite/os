{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  raycast
  stats
  # Fix macOS sed and grep
  gnused
  gnugrep
# karabiner-elements
  mas # Mac App Store CLI
]
