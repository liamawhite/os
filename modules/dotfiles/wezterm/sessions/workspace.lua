local wezterm = require("wezterm")
local mux = wezterm.mux

local workspace = {}

function workspace.setup_notes()
    local _, pane, _ = mux.spawn_window {
        workspace = 'notes',
        cwd = wezterm.home_dir .. '/notes',
    }
    pane:send_text 'nvim .\n'
end

function workspace.setup_code(workspace_name, wd)
    local tab, pane, window = mux.spawn_window {
        workspace = workspace_name,
        cwd = wd,
    }
    pane:send_text 'nvim .\n'
    window:spawn_tab { cwd = wd }
    tab:activate()
end

return workspace
