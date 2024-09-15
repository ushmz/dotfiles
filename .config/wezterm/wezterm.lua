local wt = require("wezterm")

local config = wt.config_builder()

local COL_ACCENT = "#4F4F4F"

wt.on("format-window-title", function(tab, pane, tabs, panes, config)
	return "WezTerm"
end)

wt.on("window-config-reloaded", function(window, pane)
	window.log_info("Window config reloaded")
end)

wt.on("update-right-status", function(window, pane, config)
	local cwd = pane:get_current_working_dir()
	if cwd then
		window:set_right_status(wt.format({
			{ Attribute = { Bold = true } },
			{ Text = cwd .. " on " },
		}))
	end
end)

-- General
config.audible_bell = "Disabled"
config.automatically_reload_config = true
config.scrollback_lines = 10000
config.default_prog = {
	"/opt/homebrew/bin/zsh",
	"-l",
	"-c",
	"/opt/homebrew/bin/tmux a -t sub || /opt/homebrew/bin/tmux new -s sub",
}
config.inactive_pane_hsb = {
	saturation = 0.85,
	brightness = 0.85,
}
config.keys = {
	{ key = "f", mods = "CTRL|CMD", action = wt.action.ToggleFullScreen },
}
config.use_ime = true

-- Theme
config.color_scheme = "Hybrid (Gogh)"
config.colors = {
	background = "#27292c",
	foreground = "#c5c8c6",
	selection_bg = COL_ACCENT,
	ansi = {
		"#1d1f21",
		"#cc6666",
		"#dffebe",
		"#f0d189",
		"#96b1c9",
		"#bfa5c7",
		"#9fc9c3",
		"#fcf7e2",
	},
	brights = {
		"#484c52",
		"#d27c7b",
		"#95ad68",
		"#f0c674",
		"#81a2be",
		"#b294bb",
		"#8abeb7",
		"#c5c8c6",
	},
}

-- Font => --> ~~>>
config.bold_brightens_ansi_colors = true
config.font_size = 14
config.font = wt.font_with_fallback({
	{ family = "FiraCode Nerd Font", weight = "Medium", style = "Normal" },
	{ family = "FiraMono Nerd Font", weight = "Medium", style = "Normal" },
	{ family = "Mononoki Nerd Font", weight = "Medium", style = "Normal" },
	{ family = "Hack Nerd Font", weight = "Medium", style = "Normal" },
})
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.text_background_opacity = 0.5
config.cell_width = 1.0
config.line_height = 1.0
config.use_cap_height_to_scale_fallback_fonts = false
config.adjust_window_size_when_changing_font_size = false

-- Tab bar
config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 25

-- Window
config.initial_cols = 150
config.initial_rows = 80
config.window_close_confirmation = "NeverPrompt"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.hyperlink_rules = {
	-- Linkify things that look like URLs
	-- This is actually the default if you don't specify any hyperlink_rules
	{ regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b", format = "$0" },

	-- match the URL with a PORT
	-- such 'http://localhost:3000/index.html'
	{ regex = "\\b\\w+://(?:[\\w.-]+):\\d+\\S*\\b", format = "$0" },

	-- linkify email addresses
	{ regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b", format = "mailto:$0" },

	-- file:// URI
	{ regex = "\\bfile://\\S*\\b", format = "$0" },
}

return config
