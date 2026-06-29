# Auto-attach to tmux when starting Ghostty outside of tmux
if [[ "$TERM_PROGRAM" == "ghostty" ]] && [[ -z "$TMUX" ]]; then
    tmux new-session -A -s main
fi

# Ensure window naming daemon is running
if [[ -n "$TMUX" ]] && ! pgrep -f tmux-claude-daemon > /dev/null 2>&1; then
    ~/bin/tmux-claude-daemon &!
fi
