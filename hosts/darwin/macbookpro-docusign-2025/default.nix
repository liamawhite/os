{ ... }:

{
  imports = [ ../shared.nix ];

  # Unique nixbld group ID for this host
  ids.gids.nixbld = 30000;

  # Host-specific configuration
  networking.computerName = "MacBook Pro DocuSign 2025";
  networking.hostName = "macbookpro-docusign-2025";
}