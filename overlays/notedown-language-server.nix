{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "notedown-language-server";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "notedownorg";
    repo = "language-server";
    rev = "v${version}";
    sha256 = "sha256-+rTemXr2WzMFHvj84DV+wgrlwQIgPm0wPJDSiXQFW58=";
  };

  vendorHash = "sha256-iiyJm9BNW6ZWuj1nNfRxZHfTAVD+Vhq/4ysgAWZFZow=";

  ldflags = [
    "-w"
    "-s"
    "-X github.com/notedownorg/language-server/pkg/version.version=${version}"
    "-X github.com/notedownorg/language-server/pkg/version.commit=${src.rev}"
    "-X github.com/notedownorg/language-server/pkg/version.date=1970-01-01T00:00:00Z"
  ];

  postInstall = ''
    mv $out/bin/language-server $out/bin/notedown-language-server
  '';

  doCheck = false;

  meta = with lib; {
    description = "Language Server Protocol implementation for Notedown";
    homepage = "https://github.com/notedownorg/language-server";
    license = licenses.mit;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
