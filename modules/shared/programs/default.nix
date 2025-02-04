{ user, email, ... }:

{
  git = {
    enable = true;
    ignores = [ "*.swp" ".DS_Store" ];
    userName = user;
    userEmail = email;
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
}
