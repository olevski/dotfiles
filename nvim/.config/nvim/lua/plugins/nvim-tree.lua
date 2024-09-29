return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")
				api.config.mappings.default_on_attach(bufnr)
			end,
		})
		-- Do not show the statusline in nvim tree
		local disableStatusline = function(args)
			vim.b[args.buf].ministatusline_disable = true
		end
		vim.api.nvim_create_autocmd("Filetype", { pattern = "NvimTree", callback = disableStatusline })
	end,
}
