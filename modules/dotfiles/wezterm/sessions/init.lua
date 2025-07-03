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
    -- workspace.setup_notes()
end

local function add_directory_choices(choices, base_dir, label_prefix, min_depth, max_depth)
    local dirs = utils.find(base_dir, 'd', min_depth, max_depth)
    if not dirs then
        return
    end

    for _, dir in ipairs(dirs) do
        -- filter .git, .stversions and .bare subdirectories
        if string.match(dir, '/%.git') or string.match(dir, '/%.stversions') or string.match(dir, '/%.bare') then
            goto continue
        end

        -- trim base_dir from dir and add prefix if provided
        local label = string.sub(dir, string.len(base_dir) + 2)
        if label_prefix then
            label = label_prefix .. label
        end

        table.insert(choices, { label = label, id = dir })
        ::continue::
    end
end

function manager.choices()
    local choices = {}

    local github_dir = wezterm.home_dir .. '/github.com'
    local docusign_github_dir = wezterm.home_dir .. '/github.docusignhq.com'
    local notes_dir = wezterm.home_dir .. '/notes'

    add_directory_choices(choices, github_dir, nil, 2, 2)
    add_directory_choices(choices, docusign_github_dir, nil, 2, 2)
    add_directory_choices(choices, notes_dir, "notes/", 1, 1)

    return choices
end

return manager
