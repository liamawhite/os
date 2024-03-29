return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
                ensure_installed = { "bash", "c", "cpp", "csv", "dockerfile", "gitignore", "go", "gomod", "gosum", "gowork", "html", "javascript", "json", "lua", "make", "markdown", "markdown_inline", "python", "regex", "rust", "sql", "terraform", "tsx", "typescript", "vim", "yaml" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
                enable_autocmd = false,
            })
        end
    },
    {
        "nvim-treesitter/playground",
    },
    {
        'numToStr/Comment.nvim',
        lazy = false,
        dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
        config = function()
            require('Comment').setup({
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            })
        end,
    },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
    },
}
