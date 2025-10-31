self: super: {
  gh-copilot = super.stdenv.mkDerivation rec {
    pname = "gh-copilot";
    version = "latest";
    src = ./.; # Use the current directory as a dummy source

    buildInputs = [ super.nodejs ];

    installPhase = ''
      mkdir -p $out/lib/node_modules
      npm install -g --prefix=$out @github/copilot
      mkdir -p $out/bin
      for bin in $out/lib/node_modules/@github/copilot/bin/*; do
        ln -s $bin $out/bin/
      done
    '';

    meta = with super.lib; {
      description = "GitHub Copilot npm package";
      homepage = "https://www.npmjs.com/package/@github/copilot";
      license = licenses.mit;
      platforms = platforms.all;
    };
  };
}
