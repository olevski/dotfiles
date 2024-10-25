-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha"
config.colors = { background = "black" }
config.font = wezterm.font("VictorMono Nerd Font Mono", { weight = "DemiBold" })
config.line_height = 0.85
config.font_size = 13.0
config.default_cursor_style = "BlinkingBar"

config.enable_tab_bar = false
config.window_decorations = "RESIZE"

config.window_padding = {
	left = "1.0cell",
	right = "1.0cell",
	top = "0.2cell",
	bottom = "0.2cell",
}

-- Make wezterm start maximized
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

-- and finally, return the configuration to wezterm
return config
