{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "worktree";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "liamawhite";
    repo = "worktree";
    rev = "v${version}";
    sha256 = "sha256-/KnugRQQ/CQdrEP57aG48UBW7OGT9IFreL1+6MB7EIE=";
  };

  vendorHash = "sha256-E240usBl6kFhLXlo8ktgdW3PMtP/Qg2yz9n0Ctbkas8=";

  # Build with version info and optimization flags matching Makefile
  ldflags = [
    "-w"
    "-s"
    "-X github.com/liamawhite/worktree/pkg/version.version=${version}"
    "-X github.com/liamawhite/worktree/pkg/version.commit=${src.rev}"
  ];

  doCheck = false;

  meta = with lib; {
    description = "Git workflow CLI tool for managing worktrees";
    homepage = "https://github.com/liamawhite/worktree";
    license = licenses.asl20;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
