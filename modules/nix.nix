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

  # Build an augmented CA bundle at switch time by appending any corporate
  # proxy root certs (e.g. Zscaler) from the macOS system keychain onto the
  # standard nss-cacert bundle. On machines without such certs the keychain
  # lookup returns nothing and the bundle is equivalent to the default.
  #
  # nix-darwin wires NIX_SSL_CERT_FILE from environment.variables into the
  # nix-daemon launchd plist, so all nix builds that inherit NIX_SSL_CERT_FILE
  # via impureEnvVars (e.g. Go module FODs) automatically trust the corporate CA.
  environment.variables.NIX_SSL_CERT_FILE = "/etc/nix/ssl/ca-bundle.crt";

  system.activationScripts.nixCACerts.text = ''
    mkdir -p /etc/nix/ssl
    cp -f ${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt /etc/nix/ssl/ca-bundle.crt
    /usr/bin/security find-certificate -a -p -c "Zscaler" \
      /Library/Keychains/System.keychain >> /etc/nix/ssl/ca-bundle.crt 2>/dev/null || true
    chmod 644 /etc/nix/ssl/ca-bundle.crt
  '';
}

