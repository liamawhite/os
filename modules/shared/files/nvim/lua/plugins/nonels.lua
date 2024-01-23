return {
    'nvimtools/none-ls.nvim',
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,

                null_ls.builtins.formatting.prettier,
                null_ls.builtins.diagnostics.eslint,

                null_ls.builtins.rustfmt,
                null_ls.builtins.completion.spell,
            },
        })
    end,
    keys = function()
        return {
            {

                '<leader>cf',
                function()
                    vim.lsp.buf.format()
                end,
                desc = "Code formatting",
            }
        }
    end
}
