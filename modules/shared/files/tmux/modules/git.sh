show_git() {
  local index=$1
  local icon=$(get_tmux_option "@catppuccin_git_icon" "")
  local color="$(get_tmux_option "@catppuccin_git_color" "$thm_bg")"
  local text="$(get_tmux_option "@catppuccin_git_text" "#(gitmux -cfg $HOME/.tmux/modules/gitmux.yaml "#{pane_current_path}")")"

  local module=$( build_status_module "$index" "$icon" "$color" "$text" )

  echo "$module"
}