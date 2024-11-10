-- Effectively a fork of https://github.com/danielcopper/wezterm-session-manager
local wezterm = require("wezterm")
local workspace = require("sessions.workspace")
local utils = require("sessions.utils")
local history = require("sessions.history")
local mux = wezterm.mux
local manager = {}

function manager.attach()
    -- wezterm.on('update-status', function(window) manager.save_workspace_data(window) end)
    wezterm.on('gui-startup', function(_) manager.build() end)
end

function manager.build()
    workspace.setup_notes()
    workspace.setup_task()
    mux.set_active_workspace 'notes'
    history.handle_jump('notes')
end

function manager.choices()
    local choices = {}

    -- Github directories
    local github_dir = wezterm.home_dir .. '/github.com'
    local github_dirs = utils.find(github_dir, 'd', 2, 3)
    if not github_dirs then
        utils.display_notification("no github directories found in " .. github_dir)
        return choices
    end
    for _, dir in ipairs(github_dirs) do
        -- filter .git, .stversions and .bare subdirectories
        if string.match(dir, '/%.git') or string.match(dir, '/%.stversions') or string.match(dir, '/%.bare') then
            goto continue
        end

        -- trim github_dir from dir
        local label = string.sub(dir, string.len(github_dir) + 2)

        table.insert(choices, { label = label, id = dir })
        ::continue::
    end
    return choices
end

return manager
