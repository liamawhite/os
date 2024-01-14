vim.cmd("set cmdheight=0")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set noshowmode")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4

-- Disable netrw
vim.g.loaded_netrwPlugin = 1