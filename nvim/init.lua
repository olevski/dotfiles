require("config.lazy")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"

vim.api.nvim_set_keymap("n", "<leader>f", ":NvimTreeToggle<cr>", { silent = true, noremap = true })

vim.cmd.colorscheme("catppuccin-mocha")

-- Indent detection should take care of the other settings
vim.opt.tabstop = 4

require("config.vim-settings")
require("config.key-mappings")
