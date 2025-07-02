{ pkgs, user, home, ... }:
{
  users.users.${user} = {
    inherit home;
    name = "${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };
}

