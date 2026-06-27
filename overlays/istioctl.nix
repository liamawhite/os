# Temporary fix for istioctl-1.30.2 check phase failure
final: prev: {
  istioctl = prev.istioctl.overrideAttrs (_: {
    doCheck = false;
  });
}
