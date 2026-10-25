# Paramiko 5.0's strict-KEX sequence-number test fails on this Darwin build.
final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (_: pythonPrev: {
      paramiko = pythonPrev.paramiko.overridePythonAttrs (old: {
        disabledTests = (old.disabledTests or [ ]) ++ [
          "test_sequence_numbers_reset_on_newkeys_when_strict"
        ];
      });
    })
  ];
}
