return {
    { "folke/neodev.nvim" },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "folke/neodev.nvim",
            "folke/lazydev.nvim",
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            vim.lsp.config('*', { capabilities = capabilities })

            vim.lsp.config('gopls', {
                cmd = { "gopls" },
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                root_markers = { "go.work", "go.mod", ".git" },
                settings = {
                    gopls = {
                        completeUnimported = true,
                    },
                },
            })
            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        completion = { callSnippet = "Replace" },
                    },
                },
            })
            vim.lsp.config('nil_ls', {
                settings = {
                    ['nil'] = {
                        formatting = {
                            command = { "nixpkgs-fmt" },
                        },
                    },
                },
            })
            vim.lsp.config('ts_ls', {
                init_options = {
                    hostInfo = "neovim",
                    maxTsServerMemory = 15360,
                },
            })

            vim.lsp.enable({
                'bashls', 'buf_ls', 'cssls', 'gopls', 'pyright',
                'lua_ls', 'nil_ls', 'rust_analyzer', 'tailwindcss',
                'ts_ls', 'yamlls', 'terraformls', 'clangd',
            })

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then return end

                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = args.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

                    vim.keymap.set('n', 'dj', vim.diagnostic.goto_next, opts)
                    vim.keymap.set('n', 'dk', vim.diagnostic.goto_prev, opts)

                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

                    -- Autoformat on save
                    if client.supports_method('textDocument/formatting') then
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ buf = args.buf, id = client.id })
                            end,
                        })
                    end
                end,
            })
        end,
    },
}
