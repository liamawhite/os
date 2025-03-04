{ user, pkgs, ... }:

{

  imports = [
    ../../modules/darwin
    ../../modules/shared
  ];

  nix = {
    enable = true;
    package = pkgs.nixVersions.latest; # not macos specific
    settings.trusted-users = [ "@admin" "${user}" ];

    gc = {
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
    packages = [ pkgs.nerd-fonts.jetbrains-mono ];
  };

  system = import ./system.nix;
}
