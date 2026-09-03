# mermaid-cli bundles puppeteer-core but doesn't bundle Chromium.
# On macOS, pkgs.chromium is unavailable, so nixpkgs skips setting
# PUPPETEER_EXECUTABLE_PATH. Override to use google-chrome instead.
final: prev: {
  mermaid-cli = prev.mermaid-cli.override { chromium = final.google-chrome; };
}
