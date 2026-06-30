require("catppuccin").setup({
    flavour = "mocha",
    term_colors = true,
    integrations = {
        neotree = true,
        gitsigns = true,
        telescope = { enabled = true },
    },
})
vim.cmd.colorscheme("catppuccin")
