if [[ "$TERM_PROGRAM" == "ghostty" ]] && [[ -z "$TMUX" ]]; then
  tmux new-session -A -s main
fi
