local function config()
	require("modes").setup({
		colors = {
			copy = "#F0C674",
			delete = "#CC6666",
			insert = "#282A2E",
			visual = "#B294BB",
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
		ignore_filetypes = { "TelescopePrompt" },
	})
end

return {
	"mvllow/modes.nvim",
	event = { "BufRead" },
	config = config,
}
