{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "worktree";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "liamawhite";
    repo = "worktree";
    rev = "v${version}";
    sha256 = "sha256-/IoL0mJzynN+4OaWyTTunq98hwRZxtHxakDjPnbVj+o=";
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
