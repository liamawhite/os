{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "workstreams";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "liamawhite";
    repo = "workstreams";
    rev = "v${version}";
    sha256 = "sha256-sMGNq3/T/i1uWRhxC0kMVsOe85b6mOPjx/ykuWPRtbM=";
  };

  vendorHash = "sha256-X7PzJl2NCUgQYcnnSfsZXBQKNTBL4KdCCQtP7YvIdyA=";

  ldflags = [
    "-X github.com/liamawhite/workstreams/cmd.Version=v${version}"
    "-X github.com/liamawhite/workstreams/cmd.Commit=${src.rev}"
  ];

  doCheck = false;

  meta = with lib; {
    description = "CLI tool for managing workstreams";
    homepage = "https://github.com/liamawhite/workstreams";
    license = licenses.asl20;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
