return {
    dir = "~/.config/notedown/nvim",
    name = "notedown",
    config = function()
        vim.treesitter.language.register('markdown', 'notedown')

        require("notedown").setup({
            parser = {
                mode = "auto",
                notedown_workspaces = {
                    "~/notes",
                    "/tmp/notedown_demo_workspace",
                }
            }
        })
    end,
}
