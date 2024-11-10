local wezterm = require 'wezterm'
local session = require 'sessions'
local workspace = require 'sessions.workspace'
local act = wezterm.action
local module = {}

local function contains(array, element)
    for _, value in ipairs(array) do
        if value == element then
            return true
        end
    end
    return false
end

function module.apply_to_config(config)
    local keys = {}

    -- Turn off the default CMD-m Hide action, allowing CMD-m to
    -- be potentially recognized and handled by the table
    table.insert(keys, {
        key = 'm',
        mods = 'CMD',
        action = act.DisableDefaultAssignment,
    })

    -- Jump workspace
    table.insert(keys, {
        key = 'j',
        mods = 'CMD',
        action = wezterm.action_callback(function(window, pane)
            local choices = session.choices()
            window:perform_action(
                act.InputSelector {
                    action = wezterm.action_callback(
                        function(inner_window, inner_pane, id, label)
                            if not id and not label then
                                wezterm.log_info 'cancelled'
                            else
                                wezterm.log_info('id = ' .. id .. ' label = ' .. label)
                                inner_window:perform_action(
                                    act.SwitchToWorkspace { name = label, spawn = { label = label, cwd = id } },
                                    inner_pane
                                )
                            end
                        end
                    ),
                    title = 'jump',
                    choices = choices,
                    fuzzy = true,
                    fuzzy_description = '> ',
                },
                pane
            )
        end),

    })

    -- Notes
    table.insert(keys, {
        key = 'n',
        mods = 'CMD',
        action = act.SwitchToWorkspace { name = 'notes' },
    })
    -- Task Manager
    table.insert(keys, {
        key = 'a',
        mods = 'CMD',
        action = act.SwitchToWorkspace { name = 'task' },
    })
    -- -- Remap last session to out (o)
    -- table.insert(keys, {
    --     key = 'o',
    --     mods = 'CMD',
    --     action = act.Multiple { tmux_prefix, act.SendKey { key = 'L' } },
    -- })


    config.keys = keys
end

return module
