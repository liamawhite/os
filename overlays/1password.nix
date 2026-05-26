# 1Password updated their 8.12.21 binary in-place; override with the actual hash
final: prev: {
  _1password-gui = prev._1password-gui.overrideAttrs (_: {
    src = prev.fetchurl {
      url = "https://downloads.1password.com/mac/1Password-8.12.21-aarch64.zip";
      hash = "sha256-WrWbGzBK65tVNl9Dc3OnJURiPpfbNLOYUJcVT0ETaAs=";
    };
  });
}
