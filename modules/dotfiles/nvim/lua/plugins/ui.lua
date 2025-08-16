local conditions = {
    buffer_not_empty = function()
        local filename = vim.api.nvim_buf_get_name(0)
        if vim.fn.len(filename) == 0 then
            return false
        end
        if vim.bo.filetype == 'neo-tree' or vim.bo.filetype == 'Trouble' or vim.bo.filetype == 'toggleterm' then
            return false
        end
        return true
    end,
}

return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim",
        },
        opts = {
            enable_git_status = true,
            window = {
                position = "left",
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_hidden = false,
                    never_show = {
                        ".DS_Store",
                        "thumbs.db"
                    },
                },
                follow_current_file = {
                    enabled = true,                     -- This will find and focus the file in the active buffer.
                    leave_dirs_open = false,            -- closes auto expanded dirs
                },
                hijack_netrw_behavior = "open_default", -- netrw is left enabled to support gx
                use_libuv_file_watcher = true,          -- Auto-refresh filesystem changes
            },
        },
        keys = function()
            return {
                {
                    "<leader>ee",
                    ":Neotree filesystem toggle <CR>",
                    desc = "Open file explorer",
                }
            }
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local lsps = function()
                local clients = vim.lsp.buf_get_clients()
                if next(clients) == nil then
                    return 'No Active Lsp'
                end
                local clientMsgs = {}
                for _, client in pairs(clients) do
                    table.insert(clientMsgs, client.name)
                end
                return table.concat(clientMsgs, "/")
            end
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "catppuccin",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    always_divide_middle = true,
                    globalstatus = true,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "diagnostics", "searchcount" },
                    lualine_c = { { "filename", cond = conditions.buffer_not_empty } },
                    lualine_x = { lsps },
                    lualine_y = { "filetype" },
                    lualine_z = { "location" },
                },
                tabline = {},
                inactive_winbar = {},
                extensions = {},
            })
        end
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = false, -- keep default search experience
                    command_palette = false, -- keep default cmdline experience
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
            })
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {}
    },
}
