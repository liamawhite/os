{ licenser, nix-ai-tools, mattpocock-skills, superwhisper-source, ... }:

{
  nixpkgs.overlays = [
    licenser.overlay
    (import ./nix-ai-tools.nix)
(import ./istioctl.nix)
    (import ./mermaid-cli.nix)
    (import ./poetry.nix)
    (import ./minikube.nix)
    (final: prev: {
      worktree = prev.callPackage ./worktree.nix { };
      workstreams = prev.callPackage ./workstreams.nix { };
      kubetype-gen = prev.callPackage ./kubetype-gen.nix { };
      mattpocock-skills = prev.callPackage ./mattpocock-skills.nix { src = mattpocock-skills; };
      superwhisper = prev.callPackage ./superwhisper.nix { src = superwhisper-source; };
      # Add nix-ai-tools packages to pkgs
      nix-ai-tools = nix-ai-tools;

      # Temporary fix for kubelogin to skip tests
      # The tests fail on macOS due to keychain access issues in the nix sandbox
      kubelogin = prev.kubelogin.overrideAttrs (oldAttrs: {
        doCheck = false;
      });

    })
  ];
}
