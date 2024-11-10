local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

local appearance = require 'appearance'
local keys = require 'keys'
local sessions = require 'sessions'

appearance.apply_to_config(config)
keys.apply_to_config(config)
sessions.attach()

return config
