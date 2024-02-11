function on_list_vsplit(options)
    -- if there are multiple items, warn the user
    if #options.items > 1 then
      vim.notify("Multiple items found, opening first one", vim.log.levels.WARN)
    end

    if #options.items == 0 then
        vim.notify("No items found", vim.log.levels.WARN)
      end

    -- Open the first item in a vertical split
    local item = options.items[1]
    local cmd = "vsplit +" .. item.lnum .. " " .. item.filename .. "|" .. "normal " .. item.col .. "|"

    vim.cmd(cmd)
end



return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls",
                    "gopls",
                    "lua_ls",
                    "rust_analyzer",
                    "tailwindcss",
                    "tsserver",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            lspconfig.bashls.setup({ capabilities = capabilities })
            lspconfig.gopls.setup({ capabilities = capabilities })
            lspconfig.lua_ls.setup({ capabilities = capabilities })
            lspconfig.rust_analyzer.setup({ capabilities = capabilities })
            lspconfig.tailwindcss.setup({ capabilities = capabilities })
            lspconfig.tsserver.setup({ capabilities = capabilities })

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- vertical split versions
                    local vsplit = {
                        definition = function()
                            vim.lsp.buf.definition({ on_list = on_list_vsplit })
                        end,
                        declaration = function()
                            vim.lsp.buf.declaration({ on_list = on_list_vsplit })
                        end,
                        implementation = function()
                            vim.lsp.buf.implementation({ on_list = on_list_vsplit })
                        end,
                    }

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vsplit.declaration, opts)
                    vim.keymap.set('n', 'gd', vsplit.definition, opts)
                    vim.keymap.set('n', 'gi', vsplit.implementation, opts)

                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<leader>f', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
                end,
            })
        end,
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
    }
}
