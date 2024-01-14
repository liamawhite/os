return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        keys = function()
            return {
                {
                    '<leader>tt',
                    ':ToggleTerm direction=float <CR>',
                    desc = 'Open terminal',
                },
            }
        end,
        opts = {}
    },
}
