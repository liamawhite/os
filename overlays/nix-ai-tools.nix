final: prev: {
  # Override packages with nix-ai-tools versions
  claude-code = final.nix-ai-tools.packages.${final.stdenv.hostPlatform.system}.claude-code;
  gh-copilot = final.nix-ai-tools.packages.${final.stdenv.hostPlatform.system}.copilot-cli;
  codex = final.nix-ai-tools.packages.${final.stdenv.hostPlatform.system}.codex;
}