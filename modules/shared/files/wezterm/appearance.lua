local wezterm = require 'wezterm'

local module = {}

function module.apply_to_config(config)
    config.font = wezterm.font 'JetBrainsMono Nerd Font'
    config.font_size = 12

    config.force_reverse_video_cursor = true
    config.window_decorations= "RESIZE"

    config.window_background_opacity = 1 -- opacity
    config.color_scheme = "Catppuccin Mocha"

    config.window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    }
end

return module