return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            local neogit = require('neogit')
            neogit.setup()
            vim.keymap.set("n", "<leader>gg", neogit.open)
            vim.keymap.set("n", "<leader>gc", ":NeoGit commit<CR>")
            vim.keymap.set("n", "<leader>gp", ":NeoGit pull<CR>")
            vim.keymap.set("n", "<leader>gP", ":NeoGit push<CR>")
            vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>")
        end,
    },
    {
        'tpope/vim-rhubarb',
        config = function()
            -- Pass selection to gbrowse
            vim.keymap.set("v", "<leader>ghu", ":'<,'>GBrowse upstream:% <CR>")
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            current_line_blame = true
        },
    },
}
