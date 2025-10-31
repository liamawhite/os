final: prev: {
  # Override packages with nix-ai-tools versions
  claude-code = final.nix-ai-tools.packages.${final.system}.claude-code;
  gh-copilot = final.nix-ai-tools.packages.${final.system}.copilot-cli;
}