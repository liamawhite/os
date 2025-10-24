{ licenser, ... }:

{
  nixpkgs.overlays = [
    licenser.overlay
    (import ./kubelogin.nix)
    (final: prev: {
      worktree = prev.callPackage ./worktree.nix { };
    })
  ];
}

