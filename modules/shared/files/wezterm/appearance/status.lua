local wezterm = require 'wezterm'
local theme = require 'appearance.theme'

local status = {}

function status.update(window, pane)
    local workspace = window:active_workspace()
    local left_edge = ""

    window:set_right_status(wezterm.format {
        -- Workspace
        { Background = { Color = theme.base } },
        { Foreground = { Color = theme.blue } },
        { Text = left_edge },
        { Background = { Color = theme.blue } },
        { Foreground = { Color = theme.base } },
        { Attribute = { Intensity = "Bold" } },
        { Text = "   " .. workspace .. " " },
    })
end

return status
