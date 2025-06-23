{ licenser, nixpkgs-stable, ... }:

{
    nixpkgs.overlays = [
        licenser.overlay
        # TODO: Remove this overlay when nix 2.28.3 build issues are resolved on macOS
        # See: https://github.com/NixOS/nixpkgs/pull/418720
        # Pin nix package to stable version to avoid 2.28.3 build issues on macOS
        (final: prev: {
            nix = nixpkgs-stable.legacyPackages.${prev.system}.nix;
            nixVersions = prev.nixVersions // {
                stable = nixpkgs-stable.legacyPackages.${prev.system}.nix;
                latest = nixpkgs-stable.legacyPackages.${prev.system}.nix;
                nix_2_24 = nixpkgs-stable.legacyPackages.${prev.system}.nix;
            };
        })
    ];
}

