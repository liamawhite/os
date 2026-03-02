{ licenser, nix-ai-tools, ... }:

{
  nixpkgs.overlays = [
    licenser.overlay
    (import ./nix-ai-tools.nix)
    (final: prev: {
      worktree = prev.callPackage ./worktree.nix { };
      notedown-language-server = prev.callPackage ./notedown-language-server.nix { };
      kubetype-gen = prev.callPackage ./kubetype-gen.nix { };
      # Add nix-ai-tools packages to pkgs
      nix-ai-tools = nix-ai-tools;

      # Temporary fix for kubelogin to skip tests
      # The tests fail on macOS due to keychain access issues in the nix sandbox
      kubelogin = prev.kubelogin.overrideAttrs (oldAttrs: {
        doCheck = false;
      });

      # Temporary fix for yt-dlp to avoid secretstorage dependency issues
      yt-dlp = prev.yt-dlp.overridePythonAttrs (o: {
        # don't use gnome keyring
        dependencies = (
          __filter
            (
              p:
                !(__elem p.pname [
                  "cffi"
                  "secretstorage"
                ])
            )
            o.dependencies
        );
      });
    })
  ];
}

