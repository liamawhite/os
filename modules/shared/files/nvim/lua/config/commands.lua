
-- Delete LSP log file
vim.api.nvim_create_user_command('LspLogKill', function()
    local log_path = vim.lsp.get_log_path()
    os.remove(log_path)
    print("LSP log deleted:", log_path)
end, {})
