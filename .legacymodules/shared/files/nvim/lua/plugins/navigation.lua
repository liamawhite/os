return {
    {
        'ggandor/leap.nvim',
        config = function()
            require('leap').create_default_mappings()
        end
    },
    {
        "rmagatti/goto-preview",
        config = function()
            local preview = require("goto-preview")
            preview.setup()
            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspGotoPreviewCfg', {}),
                callback = function(ev)
                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    -- vim.keymap.set('n', 'gD', preview.goto_preview_declaration, opts)
                    -- vim.keymap.set('n', 'gd', preview.goto_preview_definition, opts)

                    -- todo split window and close all floating windows
                end,
            })
        end,
    },
}
