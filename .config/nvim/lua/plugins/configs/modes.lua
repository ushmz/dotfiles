local theme = require("theme")

local function config()
	require("modes").setup({
		colors = {
			copy = theme.yellow,
			delete = theme.red,
			insert = theme.cyan,
			visual = theme.purple,
		},

		-- Set opacity for cursorline and number background
		line_opacity = 0.2,

		-- Enable cursor highlights
		set_cursor = true,

		-- Enable cursorline initially, and disable cursorline for inactive windows
		-- or ignored filetypes
		set_cursorline = true,

		-- Enable line number highlights to match cursorline
		set_number = false,

		-- Disable modes highlights in specified filetypes
		-- Please PR commonly ignored filetypes
		ignore_filetypes = { "TelescopePrompt" },
	})
end

return {
	"mvllow/modes.nvim",
	event = { "BufRead" },
	config = config,
}
