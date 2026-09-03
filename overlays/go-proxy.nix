# On corporate VPN, proxy.golang.org is unreachable (DNS failure or 403).
# Wrap buildGoModule so all Go packages fetch directly from source VCS instead.
# GONOSUMCHECK=* is safe here because Nix independently verifies via vendorHash.
final: prev: {
  buildGoModule = args:
    if builtins.isFunction args
    then prev.buildGoModule args
    else prev.buildGoModule (args // {
      env = (args.env or { }) // {
        GOPROXY = "direct";
        GONOSUMCHECK = "*";
      };
    });
}
