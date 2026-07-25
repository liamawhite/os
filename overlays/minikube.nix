# minikube bundles a symlinked `kubectl` binary which conflicts with the
# standalone kubectl package also installed; drop minikube's copy so ours wins
final: prev: {
  minikube = prev.minikube.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      rm -f $out/bin/kubectl
    '';
  });
}
