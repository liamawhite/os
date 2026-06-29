{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "workstreams";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "liamawhite";
    repo = "workstreams";
    rev = "v${version}";
    sha256 = "sha256-IByV2tm2iVpuvFpnzMl//HoRamZdfTPm7qY2s0gng5c=";
  };

  vendorHash = "sha256-/DvjHWgWqZO++XblUQ1hJtnm096zMm2ttdThQvZu96Q=";

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
