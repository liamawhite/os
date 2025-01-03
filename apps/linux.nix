{ self, nixpkgs, email }:

let
  mk = import ./mk.nix { inherit self nixpkgs email; };
in
system: {
  "pios-switch" = mk "pios-switch" system;
}

