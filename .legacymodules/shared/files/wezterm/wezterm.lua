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

-- Workaround for WezTerm crashing on missing glyphs
-- See: https://github.com/wezterm/wezterm/issues/6731#issuecomment-2688791909
-- TODO: Remove when https://github.com/wezterm/wezterm/issues/7048 is resolved
config.warn_about_missing_glyphs = false

return config
