return {
    {
        -- https://github.com/tpope/vim-fugitive/blob/master/doc/fugitive.txt
        'tpope/vim-fugitive',
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