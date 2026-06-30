local neogit = require('neogit')
neogit.setup({})
vim.keymap.set("n", "<leader>gg", neogit.open)
vim.keymap.set("n", "<leader>gc", ":NeoGit commit<CR>")
vim.keymap.set("n", "<leader>gp", ":NeoGit pull<CR>")
vim.keymap.set("n", "<leader>gP", ":NeoGit push<CR>")
vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>")

require('gitsigns').setup({ current_line_blame = true })
