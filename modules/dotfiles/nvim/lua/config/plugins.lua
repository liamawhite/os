vim.g.mapleader = " "

-- start packages are loaded after init.lua by default; force early so require() works
vim.cmd("packloadall")

require("plugins.catppuccin")
require("plugins.ui")
require("plugins.autosave")
require("plugins.folding")
require("plugins.git")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.lsp_extensions")
require("plugins.markdown")
require("plugins.nonels")
require("plugins.telescope")
