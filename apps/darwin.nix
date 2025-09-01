{ self, nixpkgs, email }:

let
  mk = import ./mk.nix { inherit self nixpkgs email; };
in
system: {
  "macbookpro-docusign-2025-switch" = mk "macbookpro-docusign-2025-switch" system;
  "macstudio-personal-2023-switch" = mk "macstudio-personal-2023-switch" system;
  "macbookpro-personal-2025-switch" = mk "macbookpro-personal-2025-switch" system;
}

