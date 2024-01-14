local wezterm = require 'wezterm'

local module = {}

function module.apply_to_config(config)
    config.keys = {
        -- Turn off the default CMD-m Hide action, allowing CMD-m to
        -- be potentially recognized and handled by the tab
        {
            key = 'm',
            mods = 'CMD',
            action = wezterm.action.DisableDefaultAssignment,
        },
        }
end

return module