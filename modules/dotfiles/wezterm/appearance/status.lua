local wezterm = require 'wezterm'
local theme = require 'appearance.theme'

local status = {}

local function run_shell_command(command)
    local handle = io.popen(command)
    if not handle then
        return nil
    end
    local result = handle:read("*a")
    handle:close()
    return result
end


local function get_cpu_usage()
    local os_type = run_shell_command("uname")
    if os_type == nil then
        return -1
    end
    if string.find(os_type, "Darwin") then
        local idle = tonumber(run_shell_command("top -l 1 | grep 'CPU usage' | awk '{print $7}' | sed 's/%//'"))
        if idle then
            return 100 - idle
        end
        return -1
    end
    return -1
end

function status.update(window)
    local workspace = window:active_workspace()

    -- https://github.com/wez/wezterm/issues/5939
    -- local cpu = get_cpu_usage()
    -- local cpu_background = theme.green
    -- local cpu_foreground = theme.base
    --
    -- if cpu > 70 then
    --     cpu_background = theme.red
    -- elseif cpu > 50 then
    --     cpu_background = theme.yellow
    -- end

    local edge = ""

    window:set_right_status(wezterm.format {
        -- -- Edge
        -- { Background = { Color = theme.base } },
        -- { Foreground = { Color = cpu_background } },
        -- { Text = edge },
        -- -- CPU
        -- { Background = { Color = cpu_background } },
        -- { Foreground = { Color = cpu_foreground } },
        -- { Attribute = { Intensity = "Bold" } },
        -- { Text = " " .. cpu .. "% " },
        -- -- Edge
        -- { Background = { Color = cpu_background } },
        -- { Foreground = { Color = theme.blue } },
        -- { Text = edge },
        -- Workspace
        { Background = { Color = theme.blue } },
        { Foreground = { Color = theme.base } },
        { Attribute = { Intensity = "Bold" } },
        { Text = "   " .. workspace .. " " },
    })
end

return status
