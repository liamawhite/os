{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:lnl7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#macdesktop
    darwinConfigurations = {
      macdesktop = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [ 
        ({ pkgs, ... }: {
          services.nix-daemon.enable = true; # Auto upgrade nix daemon
          nix.package = pkgs.nix; # Auto upgrade nix package
          nix.settings.experimental-features = "nix-command flakes"; # Necessary for using flakes on this system.
          system.configurationRevision = self.rev or self.dirtyRev or null; # Set Git commit hash for darwin-version.
          nixpkgs.hostPlatform = "aarch64-darwin";
          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 4;

          system.defaults = {
            dock.autohide = true;
            finder.AppleShowAllExtensions = true;
          };

          # Create /etc/zshrc that loads the nix-darwin environment.
          programs.zsh.enable = true;  # default shell on catalina
          environment.shells = [ pkgs.bash pkgs.zsh ];
          environment.loginShell = pkgs.zsh;

          fonts.fontDir.enable = true;
          fonts.fonts = [ (pkgs.nerdfonts.override { fonts = ["JetBrainsMono"]; }) ];

          # Allow installation of unfree software (e.g. raycast)
          nixpkgs.config.allowUnfree = true;
          environment.systemPackages = [
            pkgs._1password # cli
            pkgs._1password-gui
            pkgs.raycast
            pkgs.slack
          ];

          # homebrew = {
          #   enable = true;
          # }
        })
      ];
    };
    };
    homeConfigurations = {
      macdesktop = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [ ./machines/macdesktop/home-manager.nix ];
      };
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.macdesktop.pkgs;
  };
}
