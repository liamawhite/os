local wezterm = require 'wezterm'
local session = require 'sessions'
local history = require 'sessions.history'
local act = wezterm.action
local module = {}

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
                                history.handle_jump(label)
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

    -- Naviate back in workspace history
    table.insert(keys, {
        key = 'o',
        mods = 'CMD',
        action = wezterm.action_callback(function(window, pane)
            local workspace = history.back()
            if workspace then
                wezterm.log_info('switching to workspace ' .. workspace)
                window:perform_action(act.SwitchToWorkspace { name = workspace }, pane)
                return
            end
            wezterm.log_info('we\'ve reached the beginning of the history')
        end),
    })

    -- Naviate forward in workspace history
    table.insert(keys, {
        key = 'i',
        mods = 'CMD',
        action = wezterm.action_callback(function(window, pane)
            local workspace = history.forward()
            if workspace then
                wezterm.log_info('switching to workspace ' .. workspace)
                window:perform_action(act.SwitchToWorkspace { name = workspace }, pane)
                return
            end
            wezterm.log_info('we\'ve reached the end of the history')
        end),
    })

    -- Notes
    table.insert(keys, {
        key = 'n',
        mods = 'CMD',
        action = wezterm.action_callback(function(window, pane)
            history.handle_jump('notes')
            window:perform_action(act.SwitchToWorkspace { name = 'notes' }, pane)
        end),
    })

    config.keys = keys
end

return module
