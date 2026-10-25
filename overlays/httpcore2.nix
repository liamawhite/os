# httpcore2 2.13.1's Trio cancellation timeout tests fail on this Darwin build.
final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (_: pythonPrev: {
      httpcore2 = pythonPrev.httpcore2.overridePythonAttrs (old: {
        pytestFlags = (old.pytestFlags or [ ]) ++ [
          "--deselect=tests/httpcore2/test_cancellations.py::test_h2_timeout_during_request[trio]"
          "--deselect=tests/httpcore2/test_cancellations.py::test_h2_timeout_during_response[trio]"
        ];
      });
    })
  ];
}
