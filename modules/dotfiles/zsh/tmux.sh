# Attach once from the outer Ghostty shell; detach returns to this shell.
# Keep this file for the tmux fallback daemon below.
if [[ -o interactive && -t 0 && -t 1 && "$TERM_PROGRAM" == "ghostty" && -z "$TMUX" && "${HERDR_ENV:-}" != 1 ]] && command -v herdr >/dev/null 2>&1; then
    herdr
fi

# Ensure window naming daemon is running
if [[ -n "$TMUX" ]] && ! pgrep -f tmux-claude-daemon > /dev/null 2>&1; then
    ~/bin/tmux-claude-daemon &!
fi
