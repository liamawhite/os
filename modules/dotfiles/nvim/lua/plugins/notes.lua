return {
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = "markdown",
        event = {
            "BufReadPre " .. vim.fn.expand "~" .. "/notes/personal/*.md",
            "BufNewFile " .. vim.fn.expand "~" .. "/notes/personal/*.md",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        ---@module 'obsidian'
        ---@type obsidian.config
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "~/notes/personal",
                },
            },
        },
    },
}
