local wezterm = require("wezterm")
local utils = {}

--- Displays a notification in WezTerm.
-- @param message string: The notification message to be displayed.
function utils.display_notification(message)
    wezterm.log_info(message)
    -- Additional code to display a GUI notification can be added here if needed
end

-- Find files or directories in a directory using the `find` command
-- @param dir string: The directory to search in
-- @param type string: The type of file to search for (e.g. "f" for files, "d" for directories)
-- @param mindepth number: The minimum depth to search at
-- @param maxdepth number: The maximum depth to search at
function utils.find(dir, type, mindepth, maxdepth)
    -- build the command
    local command
    if package.config:sub(1, 1) == "\\" then
        -- Windows
        command = 'dir "' .. dir .. '" /b /s /a:' .. type
    else
        -- Unix-like
        command = 'find "' .. dir .. '" -type ' .. type
    end
    if mindepth then
        command = command .. ' -mindepth ' .. mindepth
    end
    if maxdepth then
        command = command .. ' -maxdepth ' .. maxdepth
    end

    -- execute the command
    local handle = io.popen(command)
    if not handle then
        return nil
    end
    local result = handle:read("*a")
    handle:close()

    -- parse the result into a lua table
    local found = {}
    for line in result:gmatch("[^\n]+") do
        table.insert(found, line)
    end

    return found
end

return utils
