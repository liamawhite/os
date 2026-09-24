final: prev:
let
  upstream = final.nix-ai-tools.packages.${final.stdenv.hostPlatform.system}.plannotator;
  skillNames = [ "plannotator-review" "plannotator-annotate" "plannotator-last" ];
  python = final.python3.withPackages (ps: [ ps.tomlkit ]);
in
{
  plannotator = upstream.overrideAttrs (old: {
    passthru = (old.passthru or {}) // {
      # Keep skills and CLI on the same upstream revision.
      skillFiles = final.lib.listToAttrs (final.lib.concatMap (name: [
        {
          name = ".agents/skills/${name}";
          value.source = "${upstream.src}/apps/skills/core/${name}";
        }
        {
          name = ".claude/skills/${name}";
          value.source = "${upstream.src}/apps/skills/claude/${name}";
        }
      ]) skillNames);

      configureCodex = final.writeShellScript "configure-plannotator-codex" ''
        exec ${python}/bin/python ${./configure-codex.py} "$1" ${upstream}/bin/plannotator
      '';
    };
  });
}
