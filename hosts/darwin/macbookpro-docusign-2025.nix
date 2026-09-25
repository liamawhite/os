{ pkgs, ... }:

let
  user = "liam.white";
  machine = "DSAF2J3Q36DQG";
  home = "/Users/${user}";
  root = "${home}/github.com/liamawhite/os";

  modules = path: args: if args == null then ../../modules + path else import (../../modules + path) args;
in
{
  imports = [
    # Common configuration for all machines
    (modules /nix.nix { inherit user pkgs; buildId = 350; })
    (modules /nixpkgs.nix null)
    (modules /fonts.nix { inherit pkgs; })

    # Darwin-specific configuration
    (modules /darwin/settings.nix { inherit user machine; stateVersion = 5; })
    (modules /darwin/user.nix { inherit user pkgs home; })
    (modules /darwin/home-manager.nix { inherit user; stateVersion = "23.11"; })

    # Development
    (modules /programs/development/cloud.nix { inherit user pkgs; })
    (modules /programs/development/ides.nix { inherit user pkgs; })
    (modules /programs/development/ds.nix { inherit user pkgs; })
    (modules /programs/development/agents.nix { inherit user pkgs; })

    # Terminal and Dotfiles
    (modules /programs/terminal/darwin.nix { inherit user pkgs; })
    (modules /dotfiles/default.nix {
      inherit user pkgs root;
      secretsFiles = [
        ../../secrets/docusign/claudecode.env
        ../../secrets/docusign/jira.env
        ../../secrets/docusign/llmhub.env
      ];
    })

    # GUI Applications
    (modules /programs/1password/darwin.nix null)
    (modules /programs/obsidian/default.nix { inherit user pkgs; })
    (modules /programs/productivity/default.nix { inherit user pkgs; })
  ];

  # Corporate Go module fetching must not affect personal machines.
  nixpkgs.overlays = [ (import ../../overlays/go-proxy.nix) ];

  # Build an augmented CA bundle at switch time by appending any corporate
  # proxy root certs (e.g. Zscaler) from the macOS system keychain onto the
  # standard nss-cacert bundle. This is only needed on the DocuSign machine.
  #
  # nix-darwin wires NIX_SSL_CERT_FILE from environment.variables into the
  # nix-daemon launchd plist, so all nix builds that inherit NIX_SSL_CERT_FILE
  # via impureEnvVars (e.g. Go module FODs) automatically trust the corporate CA.
  environment.variables.NIX_SSL_CERT_FILE = "/etc/nix/ssl/ca-bundle.crt";

  # nix-darwin only invokes its predefined activation hooks. Run after the
  # activation checks and before launchd starts/reloads the Nix daemon.
  system.activationScripts.extraActivation.text = ''
    mkdir -p /etc/nix/ssl
    nix_ca_bundle=$(mktemp /etc/nix/ssl/ca-bundle.crt.XXXXXX)
    cp ${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt "$nix_ca_bundle"
    /usr/bin/security find-certificate -a -p -c "Zscaler" \
      /Library/Keychains/System.keychain >> "$nix_ca_bundle" 2>/dev/null || true
    chmod 644 "$nix_ca_bundle"
    mv -f "$nix_ca_bundle" /etc/nix/ssl/ca-bundle.crt
  '';
}

