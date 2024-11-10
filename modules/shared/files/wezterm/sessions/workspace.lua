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

function workspace.setup_task()
    local _, pane, _ = mux.spawn_window {
        workspace = 'task',
        cwd = wezterm.home_dir .. '/notes',
    }
    pane:send_text 'task\n'
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

--- Retrieves the current workspace data from the active window.
-- @return table or nil: The workspace data table or nil if no active window is found.
function workspace.retrieve_data(window)
    local workspace_name = window:active_workspace()
    local workspace_data = {
        name = workspace_name,
        tabs = {}
    }

    -- Iterate over tabs in the current window
    for _, tab in ipairs(window:mux_window():tabs()) do
        local tab_data = {
            tab_id = tostring(tab:tab_id()),
            panes = {}
        }

        -- Iterate over panes in the current tab
        for _, pane_info in ipairs(tab:panes_with_info()) do
            -- Collect pane details, including layout and process information
            table.insert(tab_data.panes, {
                pane_id = tostring(pane_info.pane:pane_id()),
                index = pane_info.index,
                is_active = pane_info.is_active,
                is_zoomed = pane_info.is_zoomed,
                left = pane_info.left,
                top = pane_info.top,
                width = pane_info.width,
                height = pane_info.height,
                pixel_width = pane_info.pixel_width,
                pixel_height = pane_info.pixel_height,
                cwd = tostring(pane_info.pane:get_current_working_dir()),
                tty = tostring(pane_info.pane:get_foreground_process_name())
            })
        end

        table.insert(workspace_data.tabs, tab_data)
    end
    return workspace_data
end

return workspace
