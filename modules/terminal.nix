{ config, pkgs, pkgsUnstable, libs, ... }: {
    home.packages = with pkgs; [
        wezterm
        neovim

        # Tools
        git
        wget
        bat
        bottom
        fzf
        tree
        du-dust
        ripgrep
        jq
        tmux
    ];
}