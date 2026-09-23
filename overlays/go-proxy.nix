# On corporate VPN, proxy.golang.org TLS is intercepted by Zscaler, whose CA
# is not in the nix nss-cacert bundle. The nix daemon itself can reach
# cache.nixos.org without issues (not intercepted), so only Go module fetches
# need the augmented cert. We inject it directly into each go-modules FOD so
# that builds work regardless of daemon environment — no bootstrapping needed.
#
# The corporate root CA is stored in secrets/docusign/zscaler-root-ca.pem
# (git-crypt encrypted). If the file is absent or not a valid PEM cert
# (e.g. git-crypt not unlocked), the standard cacert bundle is used unchanged.
#
# We keep the default GOPROXY so the proxy handles monorepo module resolution
# (e.g. tencentcloud-sdk-go) which breaks with GOPROXY=direct.
#
# overrideModAttrs removes GOPROXY and NIX_SSL_CERT_FILE from impureEnvVars so
# our fixed cert bundle takes effect instead of the daemon's environment.
#
# NOTE: buildGoModule aliases buildGo126Module; buildGoLatestModule aliases
# buildGo127Module. Both must be wrapped — packages like terraform explicitly
# use buildGo127Module.
final: prev:
  let
    certFile = ../secrets/docusign/zscaler-root-ca.pem;

    augmentedCerts = final.runCommand "cacert-bundle" { } (
      ''
        mkdir -p $out/etc/ssl/certs
        cp ${final.cacert}/etc/ssl/certs/ca-bundle.crt $out/etc/ssl/certs/ca-bundle.crt
      '' + (if builtins.pathExists certFile then ''
        if grep -q "BEGIN CERTIFICATE" ${certFile}; then
          cat ${certFile} >> $out/etc/ssl/certs/ca-bundle.crt
        fi
      '' else "")
    );

    wrap = fn: args:
      if builtins.isFunction args
      then fn args
      else fn (args // {
        env = (args.env or { }) // {
          GONOSUMDB = "*";
          GOINSECURE = "*";
        };
        overrideModAttrs = finalAttrs: previousAttrs:
          let
            existing =
              if args ? overrideModAttrs
              then args.overrideModAttrs finalAttrs previousAttrs
              else { };
          in
          existing // {
            env = (previousAttrs.env or { }) // (existing.env or { }) // {
              NIX_SSL_CERT_FILE = "${augmentedCerts}/etc/ssl/certs/ca-bundle.crt";
            };
            impureEnvVars = builtins.filter
              (v: v != "GOPROXY" && v != "NIX_SSL_CERT_FILE")
              (previousAttrs.impureEnvVars or [ ]);
          };
      });
  in
  {
    buildGo126Module = wrap prev.buildGo126Module;
    buildGo127Module = wrap prev.buildGo127Module;
  }
