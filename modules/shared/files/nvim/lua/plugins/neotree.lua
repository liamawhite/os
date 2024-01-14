return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",
    },
    opts = {
        enable_git_status = true,
        window = {
            position = "left",
        },
        filesystem = {
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_hidden = false,
                never_show = {
                    ".DS_Store",
                    "thumbs.db"
                },
            },
            follow_current_file = {
              enabled = true, -- This will find and focus the file in the active buffer.
              leave_dirs_open = false, -- closes auto expanded dirs
            },
            hijack_netrw_behavior = "open_default",
        },
    },
    keys = function()
        return {
            {
                "<leader>ee",
                ":Neotree filesystem toggle <CR>",
                desc = "Open file explorer",
            }
        }
    end
}