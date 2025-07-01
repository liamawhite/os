{ user, pkgs }:

{
    enable = true;
    package = pkgs.nixVersions.latest;
    settings = {
        trusted-users = [ "@admin" "${user}" ];
        experimental-features = ["nix-command" "flakes"];
    };

    gc = {
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };
}