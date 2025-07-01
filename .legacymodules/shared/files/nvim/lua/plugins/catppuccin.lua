return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            term_colors = true,
            -- https://github.com/catppuccin/nvim?tab=readme-ov-file#integrations
            integrations = {
                neotree=true,
                gitsigns=true,
                telescope={
                    enabled=true,
                },
            },
        })
        vim.cmd.colorscheme("catppuccin")
    end
}

