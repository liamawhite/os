{ self, nixpkgs, email }:

let
  mk = import ./mk.nix { inherit self nixpkgs email; };
in
system: {
  "macos-switch" = mk "macos-switch" system;
}

