{ pkgs, user, ... }:

let
  home = "/Users/${user}";
  root = "${home}/github.com/liamawhite/os";
in
{
  users.${user} = {
    inherit home;
    name = "${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };
}