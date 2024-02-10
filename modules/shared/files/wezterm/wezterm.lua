local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

local appearance = require 'appearance'
local keys = require 'keys'

appearance.apply_to_config(config)
keys.apply_to_config(config)

-- TODO work out why this doesnt work?
-- config.default_prog = { "zsh", "--login", "-c", "tmux attach -t default || tmux new -s default" }
-- config.debug_key_events = true

return config