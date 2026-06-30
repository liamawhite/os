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

require("neo-tree").setup({
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
            enabled = true,
            leave_dirs_open = false,
        },
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = true,
    },
})
vim.keymap.set("n", "<leader>ee", ":Neotree filesystem toggle <CR>", { desc = "Open file explorer" })

local lsps = function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
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
        theme = "catppuccin-mocha",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
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

require("noice").setup({
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
    },
})

vim.o.timeout = true
vim.o.timeoutlen = 300
require("which-key").setup({})
