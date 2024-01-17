return {
    {
        "github/copilot.vim",
    },
    {
        "hrsh7th/cmp-nvim-lsp"
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" }, -- For luasnip users.
                }, {
                    { name = "buffer" },
                }),
            })
        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local trouble = require("trouble")
            trouble.setup({
                auto_close = true,
                use_diagnostic_signs = true,
            })
            vim.keymap.set("n", "<leader>xx", function() trouble.toggle() end)
            vim.keymap.set("n", "<leader>xw", function() trouble.toggle("workspace_diagnostics") end)
            vim.keymap.set("n", "<leader>xd", function() trouble.toggle("document_diagnostics") end)
            vim.keymap.set("n", "<leader>xl", function() trouble.toggle("loclist") end)
            vim.keymap.set("n", "<leader>xq", function() trouble.toggle("quickfix") end)
        end,
    },
}
