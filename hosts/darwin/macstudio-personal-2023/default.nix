{ ... }:

{
  imports = [ ../shared.nix ];

  # Unique nixbld group ID for this host (different from macbookpro)
  ids.gids.nixbld = 350;

  # Host-specific configuration
  networking.computerName = "Mac Studio Personal 2023";
  networking.hostName = "macstudio-personal-2023";
}

