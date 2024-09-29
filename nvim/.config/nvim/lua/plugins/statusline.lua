return {
	"echasnovski/mini.statusline",
	config = function()
		local statusline = require("mini.statusline")
		-- set use_icons to true if you have a Nerd Font
		statusline.setup({ use_icons = true })
	end,
	version = false,
}
