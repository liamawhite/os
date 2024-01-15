return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            require('toggleterm').setup()
            -- <C-\\><C-n>i ensures we are always in terminal mode when toggling (not just on initial load)
            vim.keymap.set("n", "<leader>tt", ":ToggleTerm direction=float<CR><C-\\><C-n>i", { noremap = true, silent = true })
            -- Hide terminal with either <leader>tt or esc
            vim.keymap.set("t", "<leader>tt", "<C-\\><C-n>:ToggleTerm<CR>", { silent = true })
            vim.keymap.set("t", "<esc>", "<C-\\><C-n>:ToggleTerm<CR>", { silent = true })

            -- https://github.com/akinsho/toggleterm.nvim#custom-terminal-usage
            local Terminal = require('toggleterm.terminal').Terminal
            local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float", 
                    on_close = function()
                        require("neo-tree.events").fire_event("git_event")
                    end
            })
            function _lazygit_toggle()
                lazygit:toggle()
            end
            vim.keymap.set("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>" ,{noremap = true,silent = true,})

        end,
        opts = {}
    },
}
