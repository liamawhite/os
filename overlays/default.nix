{ licenser, ... }:

{
  nixpkgs.overlays = [
    licenser.overlay
    (final: prev: {
      worktree = prev.callPackage ./worktree.nix { };
    })
  ];
}

