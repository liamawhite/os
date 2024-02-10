local wezterm = require 'wezterm'
local act = wezterm.action
local module = {}

function module.apply_to_config(config)
    local tmux_prefix = act.SendKey { mods = 'CTRL', key = 'a' }

    local keys = {}

    -- Turn off the default CMD-m Hide action, allowing CMD-m to
    -- be potentially recognized and handled by the table
    table.insert(keys, {
        key = 'm',
        mods = 'CMD',
        action = act.DisableDefaultAssignment,
    })

    -- Tmux manages my "tabs" but this tells Wezterm how to control tmux
    -- These binding make tmux behave more like navigating browser tabs and allow
    -- for the use of the CMD/SUPER key with tmux
    table.insert(keys, {
        key = 't',
        mods = 'CMD',
        action = act.Multiple { tmux_prefix, act.SendKey { key = 'c' } },
    })
    table.insert(keys, {
        key = 'w',
        mods = 'CMD',
        action = act.Multiple { tmux_prefix, act.SendKey { key = '&' } },
    })
    for i = 0, 9 do
        table.insert(keys, {
            key = tostring(i),
            mods = 'CMD',
            action = act.Multiple { tmux_prefix, act.SendKey { key = tostring(i) } },
        })
    end

    config.keys = keys
end

return module
