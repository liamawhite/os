local wezterm = require 'wezterm'
local tabs = require 'appearance.tabs'
local status = require 'appearance.status'
local colors = require 'appearance.colors'

local module = {}

function module.apply_to_config(config)
    config.font = wezterm.font 'JetBrainsMono Nerd Font'
    config.font_size = 12

    -- https://github.com/wez/wezterm/issues/5990
    config.front_end = "WebGpu"

    config.force_reverse_video_cursor = true
    config.window_decorations = "RESIZE"

    config.window_background_opacity = 1
    config.color_scheme = "Catppuccin Mocha"

    config.enable_tab_bar = true
    config.use_fancy_tab_bar = false
    config.show_new_tab_button_in_tab_bar = false
    config.show_tab_index_in_tab_bar = false

    config.colors = colors

    config.window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    }

    wezterm.on('format-tab-title', tabs.formatted_title)
    wezterm.on('update-status', status.update)
end

return module
