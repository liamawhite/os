return {
    "notedownorg/notedown.nvim",
    config = function()
        vim.treesitter.language.register('markdown', 'notedown')
        require("notedown").setup({})
    end,
}
