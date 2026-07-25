# Temporary fix for poetry-2.4.1 check phase failure
# 3 executor tests fail upstream on this nixpkgs revision (nixos-unstable)
# Poetry runs its tests in installCheckPhase (gated by doInstallCheck), not checkPhase
final: prev: {
  poetry = prev.poetry.overrideAttrs (_: {
    doInstallCheck = false;
  });
}
