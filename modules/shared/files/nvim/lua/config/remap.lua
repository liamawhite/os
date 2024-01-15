vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Quick quit
-- Terminal exit bug: https://github.com/neovim/neovim/issues/14061
-- vim.keymap.set("n", "<leader>qq", ":wqa <CR>")
vim.keymap.set("n", "<leader>sa", ":wa <CR>")
vim.keymap.set("n", "<leader>qf", ":qa! <CR>")

-- Window Navigation
vim.keymap.set("n", "<C-Left>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-Right>", ":wincmd l<CR>")
vim.keymap.set("n", "<C-Up>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-Down>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
