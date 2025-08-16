vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Quick quit
vim.keymap.set("n", "ZZ", ":wa <CR>")  -- save all
vim.keymap.set("n", "ZF", ":qa! <CR>") -- quit (force)
vim.keymap.set('n', 'ZB', ":bd<CR>")   -- quit (buffer)

-- Window Navigation
vim.keymap.set("n", "<C-Left>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-Right>", ":wincmd l<CR>")
vim.keymap.set("n", "<C-Up>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-Down>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")

-- Yank shortcuts
vim.keymap.set("n", "<leader>y", '"*y')
vim.keymap.set("v", "<leader>y", '"*y')
vim.keymap.set("n", "<leader>Y", 'gg"*yG')

-- Line shifting
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Lua execution
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>") -- Source current file
vim.keymap.set("n", "<leader>x", ":.lua<CR>")                 -- Execute current line
vim.keymap.set("v", "<leader>x", ":lua<CR>")                  -- Execute selected lines

vim.keymap.set("n", "<leader>X", ":!chmod +x %<CR>")          -- Make current file executable

-- Visual mode indentation
vim.keymap.set("v", "<Tab>", ">gv")   -- Indent selection and re-select
vim.keymap.set("v", "<S-Tab>", "<gv") -- Un-indent selection and re-select
