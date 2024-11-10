local wezterm = require("wezterm")
local utils = {}

--- Displays a notification in WezTerm.
-- @param message string: The notification message to be displayed.
function utils.display_notification(message)
    wezterm.log_info(message)
    -- Additional code to display a GUI notification can be added here if needed
end

--- Saves data to a JSON file.
-- @param data table: The workspace data to be saved.
-- @param file_path string: The file path where the JSON file will be saved.
-- @return boolean: true if saving was successful, false otherwise.
function utils.save_to_json_file(data, file_path)
    if not data then
        wezterm.log_info("No workspace data to log.")
        return false
    end

    utils.ensureDirectoryExists(utils.getDirectoryFromPath(file_path))

    local file = io.open(file_path, "w")
    if file then
        file:write(wezterm.json_encode(data))
        file:close()
        return true
    else
        return false
    end
end

function utils.getDirectoryFromPath(filePath)
    return string.match(filePath, "^(.*[\\/])") -- Matches everything up to the last slash or backslash
end

-- Check if a directory exists
function utils.directoryExists(dir)
    local file = io.open(dir, "r")
    if file then
        -- The path exists, check if it's a directory
        local _, _, code = file:read(1)
        file:close()
        return code == 21 -- 21 is the error code for "Is a directory"
    end
    return false
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

-- Create a directory if it doesn't exist
function utils.ensureDirectoryExists(dir)
    if not utils.directoryExists(dir) then
        local command
        if package.config:sub(1, 1) == "\\" then
            -- Windows
            command = 'mkdir "' .. dir .. '"'
        else
            -- Unix-like
            command = 'mkdir -p "' .. dir .. '"'
        end
        os.execute(command)
    end
end

return utils
