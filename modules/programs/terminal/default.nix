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
      ffmpeg
      htop
      iftop
      jq
      yq-go
      flock
      fzf
      gh
      git-remote-gcrypt
      gnupg
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
      yt-dlp
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
        gcrypt.gpg-args = "--use-agent";
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

    programs.gpg = {
      enable = true;
      settings = {
        default-key = "A180F839D002DDB8520C128DE1B2B65F25D58D34";
      };
    };
  };
}

