{ user, pkgs, ... }:

{
  home-manager.users.${user} = { ... }: {
    home.packages = with pkgs; [
      wezterm

      bash-completion
      bat
      bottom
      btop
      coreutils
      cht-sh
      dust
      eza
      fd
      htop
      iftop
      jq
      yq-go
      flock
      fzf
      gh
      grpcurl
      inetutils
      moreutils
      nmap
      openssh
      ripgrep
      starship
      tree
      unrar
      unzip
      wget
      worktree
      zip
      zoxide
    ];

    programs.git = {
      enable = true;
      ignores = [ "*.swp" ".DS_Store" ];
      userName = "Liam White";
      difftastic = {
        enable = true;
        background = "dark";
      };
      lfs = {
        enable = true;
      };
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
        rebase.autoStash = true;
        push.autoSetupRemote = true;
        core = {
          editor = "nvim";
        };
        url = {
          "ssh://git@github.com/" = {
            insteadOf = "https://github.com/";
          };
        };
      };
    };
  };
}

