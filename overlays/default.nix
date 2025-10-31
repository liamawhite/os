{ licenser, nix-ai-tools, ... }:

{
  nixpkgs.overlays = [
    licenser.overlay
    (import ./kubelogin.nix)
    (final: prev: {
      worktree = prev.callPackage ./worktree.nix { };
      # Add nix-ai-tools packages to pkgs
      nix-ai-tools = nix-ai-tools;
    })
    (import ./nix-ai-tools.nix)
  ];
}

