{ config, lib, pkgs, ... }:

{
    imports = [
        ../../modules/home-manager.nix
        ../../modules/terminal.nix
        ../../modules/git.nix
    ];

    home = {
        stateVersion = "23.11";
        homeDirectory = "/Users/liamawhite";
        username = "liamawhite";
    };



}