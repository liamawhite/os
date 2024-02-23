return {
    'nvimtools/none-ls.nvim',
    config = function()
        local null_ls = require("null-ls")
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.gofmt,
                null_ls.builtins.formatting.goimports,

                null_ls.builtins.diagnostics.eslint,

                null_ls.builtins.rustfmt,
                null_ls.builtins.completion.spell,
            },
            -- Im not sure why this doesn't work! 
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({
                        group = augroup,
                        buffer = bufnr,
                    })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end,
                    })
                end
            end,
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
