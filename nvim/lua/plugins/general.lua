return {
	"nmac427/guess-indent.nvim",
	config = function()
		require("guess-indent").setup({
			-- on_tab_options = { -- A table of vim options when tabs are detected
			-- 	["expandtab"] = false,
			-- 	["tabstop"] = 4,
			-- 	["shiftwidth"] = 0,
			-- },
		})
	end,
}
