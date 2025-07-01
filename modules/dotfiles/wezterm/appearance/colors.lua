local theme = require 'appearance.theme'

local colors = {
    tab_bar = {
        -- The color of the strip that goes along the top of the window
        background = theme.base,

        active_tab = {
            bg_color = theme.blue,
            fg_color = theme.base,
        },

        inactive_tab = {
            bg_color = theme.base,
            fg_color = theme.overlay0,
        },
    },
}

return colors
