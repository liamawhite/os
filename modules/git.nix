{ config, pkgs, lib, libs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Liam White";
    userEmail = "liamawhite@gmail.com";
    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";
      github.user = "liamawhite";

      push.autoSetupRemote = true;

      core.editor = "nvim";
      core.fileMode = false;
      core.ignorecase = false;
    };
  };
}