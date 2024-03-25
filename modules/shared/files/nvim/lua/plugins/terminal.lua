return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            require('toggleterm').setup()
            local Terminal = require('toggleterm.terminal').Terminal

            -- Standard Terminal, its created manually so we can close them both using escape
            local terminal = Terminal:new({
                hidden = true,
                direction = "float",
                on_close = function()
                    require("neo-tree.events").fire_event("git_event")
                end
            })
            function _terminal_toggle()
                terminal:toggle()
            end

            vim.keymap.set("n", "<leader>tt", "<cmd>lua _terminal_toggle()<CR><C-\\><C-n>i",
                { noremap = true, silent = true })
            vim.keymap.set("t", "<leader>tt", "<C-\\><C-n><cmd>lua _terminal_toggle()<CR>",
                { noremap = true, silent = true })

            -- Hide all terminal with esc
            function _all_close()
                terminal:close()
            end
            vim.keymap.set("t", "<esc>", "<C-\\><C-n><cmd>lua _all_close()<CR>", { silent = true })
        end,
        opts = {}
    },
}
