# Fabric 3.2 requires Invoke 2.x; nixpkgs currently supplies Invoke 3.x.
final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (_: pythonPrev: {
      invoke = pythonPrev.invoke.overridePythonAttrs (_: {
        version = "2.2.1";
        src = final.fetchPypi {
          pname = "invoke";
          version = "2.2.1";
          hash = "sha256:515bf49b4a48932b79b024590348da22f39c4942dff991ad1fb8b8baea1be707";
        };
      });
    })
  ];
}
