local history = {
    workspaces = {},
    index = 0
}

-- If we have jumped, we need to replace everything in front of the current index with the new workspace
function history.handle_jump(workspace)
    -- If we have no workspaces or we are at the end of history, just append the new workspace
    if #history.workspaces == 0 or history.index == #history.workspaces then
        table.insert(history.workspaces, workspace)
        history.index = history.index + 1
        return
    end

    -- If we are in the middle of the history, replace everything in front of the current index with the new workspace
    local new_workspaces = {}
    for i = 1, history.index do
        table.insert(new_workspaces, history.workspaces[i])
    end
    table.insert(new_workspaces, workspace)
    history.workspaces = new_workspaces
    history.index = history.index + 1
end

-- If we have gone forward, we need to update the index and return the workspace
-- If we reached the end, return nil
function history.forward()
    if history.index == #history.workspaces then
        return nil
    end
    history.index = history.index + 1
    return history.workspaces[history.index]
end

-- If we have gone back, we need to update the index and return the workspace
-- If we reached the beginning, return nil
function history.back()
    if history.index == 1 then
        return nil
    end
    history.index = history.index - 1
    return history.workspaces[history.index]
end

return history
