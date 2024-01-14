local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

local appearance = require 'appearance'
local keys = require 'keys'
local tabs = require 'tabs'

appearance.apply_to_config(config)
keys.apply_to_config(config)
tabs.apply_to_config(config)

return config