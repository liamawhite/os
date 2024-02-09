return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
            ensure_installed = { "bash", "c", "cpp", "csv", "dockerfile", "gitignore", "go", "gomod", "gosum", "html", "javascript", "json", "lua", "make", "markdown", "markdown_inline", "python", "regex", "rust", "sql", "terraform", "typescript", "vim", "yaml" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
