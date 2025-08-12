{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "worktree";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "liamawhite";
    repo = "worktree";
    rev = "v${version}";
    sha256 = "sha256-FGNuIauWDNSHtU3SFgZcDbHr5HoBUHlSem5iAQje6P8=";
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
