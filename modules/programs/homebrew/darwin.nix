{
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap"; # Automatically uninstalls all formulae not listed in the generated Brewfile
    };
  };
}
