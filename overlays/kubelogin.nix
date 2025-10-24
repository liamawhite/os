# Overlay for kubelogin to skip tests
# The tests fail on macOS due to keychain access issues in the nix sandbox
# Error: TestSecureKeyStorage fails with "Keychain Error. (-61)"
# This is a known issue when building in sandboxed environments
final: prev: {
  kubelogin = prev.kubelogin.overrideAttrs (oldAttrs: {
    doCheck = false;
  });
}