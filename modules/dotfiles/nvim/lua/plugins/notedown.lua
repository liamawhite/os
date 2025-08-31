return {
    dir = "~/.config/notedown/nvim",
    name = "notedown",
    config = function()
        vim.treesitter.language.register('markdown', 'notedown')
        require("notedown").setup({})
    end,
}
