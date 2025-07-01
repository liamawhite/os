return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            local parser = require "nvim-treesitter.parsers".get_parser_configs()

            -- Additional parsers not included in the default install
            -- see https://github.com/nvim-treesitter/nvim-treesitter/blob/master/README.md#adding-parsers
            parser.vhs = {
                install_info = {
                    url = "https://github.com/charmbracelet/tree-sitter-vhs",
                    files = { "src/parser.c" },
                    branch = "main",
                },
                filetype = "tape",
            }

            configs.setup({
                -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
                ensure_installed = {
                    "bash", "c", "cpp", "csv", "dockerfile", "gitignore", "go", "gomod", "gosum", "gowork", "html",
                    "javascript", "json", "lua", "make", "markdown", "markdown_inline", "python", "regex", "rust", "sql",
                    "terraform", "tsx", "typescript", "vhs", "vim", "yaml"
                },
                sync_install = false,
                indent = { enable = true },
                enable_autocmd = false,
                highlight = {
                    enable = true,
                    -- Disable slow treesitter highlight for large files
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                },
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
