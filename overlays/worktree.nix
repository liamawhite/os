{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "worktree";
  version = "38d11b71e34a53b8081b0d1f4e53643d382355a3";

  src = fetchFromGitHub {
    owner = "liamawhite";
    repo = "worktree";
    rev = "38d11b71e34a53b8081b0d1f4e53643d382355a3";
    sha256 = "sha256-G6hY9rTVpwfBIUIu34BrDILiGtg4Hw8TeIFohfACBWU=";
  };

  vendorHash = "sha256-E240usBl6kFhLXlo8ktgdW3PMtP/Qg2yz9n0Ctbkas8=";

  doCheck = false;

  meta = with lib; {
    description = "Git workflow CLI tool for managing worktrees";
    homepage = "https://github.com/liamawhite/worktree";
    license = licenses.asl20;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}