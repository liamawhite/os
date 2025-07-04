{ user, pkgs, buildId }:

{
  ids.gids.nixblb = buildId;
  nix = {
    enable = true;
    package = pkgs.nixVersions.latest;
    settings = {
      trusted-users = [ "@admin" "${user}" ];
      experimental-features = [ "nix-command" "flakes" ];
      download-buffer-size = 524288000; # 500 MiB
    };

    gc = {
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };
  };
}

