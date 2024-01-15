return {
    {
        -- https://github.com/tpope/vim-fugitive/blob/master/doc/fugitive.txt
        'tpope/vim-fugitive',
        config = function()
            -- Reset to upstream master/main
            vim.keymap.set("n", "<leader>GR", ":Git fetch upstream<CR>:Git checkout master<CR>:Git reset --hard upstream/master<CR>:Git push origin master --force<CR>")
            vim.keymap.set("n", "<leader>gr", ":Git fetch upstream<CR>:Git checkout main<CR>:Git reset --hard upstream/main<CR>:Git push origin main --force<CR>")
        end
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
