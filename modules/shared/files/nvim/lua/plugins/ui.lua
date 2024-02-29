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
            "3rd/image.nvim",
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
                    enabled = true,          -- This will find and focus the file in the active buffer.
                    leave_dirs_open = false, -- closes auto expanded dirs
                },
                hijack_netrw_behavior = "open_default",
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
                -- winbar = {
                --     lualine_c = { "navic" },
                --     lualine_x = {
                --         {
                --             function()
                --                 return "  "
                --             end,
                --             cond = function()
                --                 local present, navic = pcall(require, "nvim-navic")
                --                 if not present then
                --                     return false
                --                 end
                --                 return navic.is_available()
                --             end,
                --         },
                --     },
                -- },
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
            "hrsh7th/nvim-cmp",
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
                routes = {
                    {
                        view = "notify",
                        filter = { event = "msg_showmode" },
                    },
                    {
                        filter = {
                            event = "msg_show",
                            kind = "",
                            find = "written",
                        },
                        opts = { skip = true },
                    },
                },
                presets = {
                    inc_rename = true, -- enables an input dialog for inc-rename.nvim
                },
                views = {
                    cmdline_popup = {
                        position = {
                            row = 5,
                            col = "50%",
                        },
                        size = {
                            width = 60,
                            height = "auto",
                        },
                    },
                    popupmenu = {
                        relative = "editor",
                        position = {
                            row = 8,
                            col = "50%",
                        },
                        size = {
                            width = 60,
                            height = 10,
                        },
                        border = {
                            style = "rounded",
                            padding = { 0, 1 },
                        },
                        win_options = {
                            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                        },
                    },
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
    }

}
