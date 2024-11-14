{ pkgs, licenser, system }:

with pkgs;
let shared-packages = import ../shared/packages/all.nix { inherit pkgs licenser system; }; in
shared-packages ++ [
  raycast
  stats
  gnused # Fix macOS sed and grep
  gnugrep # Fix macOS sed and grep
  mas # Mac App Store CLI
]
