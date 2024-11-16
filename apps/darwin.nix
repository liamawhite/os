{ self, nixpkgs, email }:

let
  mk = import ./mk.nix { inherit self nixpkgs email; };
in
system: {
  "build-switch" = mk "build-switch" system;
}

