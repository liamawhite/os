local theme = require 'appearance.theme'
local tabs = {}

function tabs.title(tab_info)
    local title = tab_info.tab_title
    if title and #title > 0 then
        return title                  -- if the tab title is explicitly set, take that
    end
    return tab_info.active_pane.title -- Otherwise, use the title from the active pane
end

function tabs.formatted_title(tab, tabs_info, _, config, _, _)
    local title = tabs.title(tab):match("^%s*(.-)%s*$")     -- trim whitespace
    local background = config.colors.tab_bar.inactive_tab.bg_color
    local foreground = config.colors.tab_bar.inactive_tab.fg_color
    local edge_left_outer = config.colors.tab_bar.inactive_tab.bg_color
    local edge_left_inner = config.colors.tab_bar.inactive_tab.bg_color
    local edge_right_outer = config.colors.tab_bar.inactive_tab.bg_color
    local edge_right_inner = config.colors.tab_bar.inactive_tab.bg_color
    local index = tostring(tab.tab_index + 1) .. ":"

    if tab.is_active then
        background = config.colors.tab_bar.active_tab.bg_color
        foreground = config.colors.tab_bar.active_tab.fg_color
        edge_left_inner = config.colors.tab_bar.active_tab.bg_color
        edge_right_inner = config.colors.tab_bar.active_tab.bg_color
        index = " "     -- no index for active tab
    end

    local edge_left = "█"
    local edge_right = ""

    if tab.tab_index == 0 then
        edge_left = "██"
    end
    if tab.tab_index == #tabs_info - 1 then
        edge_right_outer = config.colors.tab_bar.background
    end

    return {
        { Background = { Color = edge_left_outer } },
        { Foreground = { Color = edge_left_inner } },
        { Text = edge_left },
        { Background = { Color = background } },
        { Foreground = { Color = theme.surface1 } },
        { Text = index },
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Attribute = { Intensity = "Bold" } },
        { Text = title .. "  " },
        { Background = { Color = edge_right_outer } },
        { Foreground = { Color = edge_right_inner } },
        { Text = edge_right },
    }
end

return tabs
