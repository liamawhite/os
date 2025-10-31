{ licenser, ... }:

{
  nixpkgs.overlays = [
    licenser.overlay
    (import ./kubelogin.nix)
    # (import ./ghcopilot.nix)
    (final: prev: {
      worktree = prev.callPackage ./worktree.nix { };
    })
  ];
}

