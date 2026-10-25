# Mocket 3.14.4's Redis shutdown test hangs in the Darwin build sandbox.
final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (_: pythonPrev: {
      mocket = pythonPrev.mocket.overridePythonAttrs (old: {
        disabledTests = (old.disabledTests or [ ]) ++ [ "test_shutdown" ];
      });
    })
  ];
}
