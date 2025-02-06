require("config.lazy")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.g.have_nerd_font = true
vim.g.autoread = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"

vim.api.nvim_set_keymap("n", "<leader>f", ":NvimTreeToggle<cr>", { silent = true, noremap = true })

vim.cmd.colorscheme("catppuccin-mocha")

-- A tab is 4 spaces wide
vim.opt.tabstop = 4
-- Shiftwidth is how much to indent stuff by, when zero it uses tabstop
vim.opt.shiftwidth = 0

require("config.vim-settings")
require("config.key-mappings")
