show_ram() {
  tmux set-option -g @ram_low_bg_color "$thm_magenta" # background color when cpu is low
  tmux set-option -g @ram_medium_bg_color "$thm_orange" # background color when cpu is medium
  tmux set-option -g @ram_high_bg_color "$thm_red" # background color when cpu is high
  tmux set-option -g @ram_percentage_format "%2.0f%%"
  
  local index=$1
  local icon=$(get_tmux_option "@catppuccin_ram_icon" "#{ram_icon}")
  local color="$(get_tmux_option "@catppuccin_ram_color" "#{ram_bg_color}")"
  local text="$(get_tmux_option "@catppuccin_ram_text" "#{ram_percentage}")"

  local module=$( build_status_module "$index" "$icon" "$color" "$text" )

  echo "$module"
}