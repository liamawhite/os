-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Delete LSP log file
vim.api.nvim_create_user_command('LspLogKill', function()
    local log_path = vim.lsp.get_log_path()
    os.remove(log_path)
    print("LSP log deleted:", log_path)
end, {})
