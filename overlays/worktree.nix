{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "worktree";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "liamawhite";
    repo = "worktree";
    rev = "v${version}";
    sha256 = "sha256-n6YxAwL+2bjnX1PVoXewO/VzYKbb4y0GaS303GlkzMM=";
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