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
      du-dust
      eza
      htop
      iftop
      jq
      yq-go
      flock
      fzf
      grpcurl
      inetutils
      nmap
      openssh
      ripgrep
      starship
      tree
      unrar
      unzip
      wget
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

