return {
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
        },
        opts = {
            provider_selector = function(bufnr, filetype, buftype)
                return { "treesitter", "indent" }
            end,
        },
        config = function(_, opts)
            require("ufo").setup(opts)
            vim.opt.foldcolumn = "1"    -- '0' is not bad
            vim.opt.foldlevel = 99      -- open all folds by default
            vim.opt.foldlevelstart = 99 -- start with all folds open
            vim.opt.foldenable = true   -- enable folding
            vim.opt.foldnestmax = 4     -- Don't worry about folds beyond a certain depth
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
        end,
    },
}
