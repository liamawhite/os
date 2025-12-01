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
      lfs = {
        enable = true;
      };
      settings = {
        user.name = "Liam White";
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

    programs.difftastic = {
      enable = true;
      git.enable = true;
      options = {
        background = "dark";
      };
    };
  };
}

