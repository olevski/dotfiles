return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.diagnostics.mypy.with({
					timeout = 600000,
					command = "dmypy",
					args = function(params)
						return {
							"run",
							"--timeout",
							"5000",
							"--",
							"--hide-error-codes",
							"--hide-error-context",
							"--no-color-output",
							"--show-absolute-path",
							"--show-column-numbers",
							"--show-error-codes",
							"--no-error-summary",
							"--no-pretty",
							"--shadow-file",
							params.bufname,
							params.temp_path,
							params.bufname,
						}
					end,
					runtime_condition = function(params)
						if string.find(params.bufname, "fugitive") or string.find(params.bufname, ".venv") then
							return false
						else
							return true
						end
					end,
				}),
				null_ls.builtins.formatting.stylelint,
			},
		})
	end,
	dependencies = { "nvim-lua/plenary.nvim" },
}
