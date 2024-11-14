{ licenser, ... }:

{
    nixpkgs.overlays = [
        licenser.overlay
    ];
}

