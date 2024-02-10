show_cpu() {
  tmux set-option -g @cpu_low_bg_color "$thm_blue" # background color when cpu is low
  tmux set-option -g @cpu_medium_bg_color "$thm_orange" # background color when cpu is medium
  tmux set-option -g @cpu_high_bg_color "$thm_red" # background color when cpu is high
  tmux set-option -g @cpu_percentage_format "%2.0f%%"
  
  local index=$1
  local icon=$(get_tmux_option "@catppuccin_cpu_icon" "")
  local color="$(get_tmux_option "@catppuccin_cpu_color" "#{cpu_bg_color}")"
  local text="$(get_tmux_option "@catppuccin_cpu_text" "#{cpu_percentage}")"

  local module=$( build_status_module "$index" "$icon" "$color" "$text" )

  echo "$module"
}