return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		color_overrides = {
			-- The stuff below makes it so that the mocha background is just black
			mocha = {
				base = "#000000",
				-- mantle = "#000000",
				-- crust = "#000000",
			},
		},
	},
}
