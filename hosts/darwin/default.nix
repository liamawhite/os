{ user, pkgs, ... }:

{

  imports = [
    ../../modules/darwin
    ../../modules/shared
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nixVersions.latest; # not macos specific
    settings.trusted-users = [ "@admin" "${user}" ];

    gc = {
      user = "root";
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };

    # not macos specific
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  fonts = {
    packages = [ (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];
  };

  system = import ./system.nix;
}
