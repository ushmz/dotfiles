return {
	"petertriho/nvim-scrollbar",
	event = { "BufRead" },
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"kevinhwang91/nvim-hlslens",
	},
	config = function()
		local theme = require("plugins.utils").theme
		require("scrollbar").setup({
			max_lines = 2000,
			handle = {
				highlight = "CursorLine",
				hide_if_all_visible = true,
			},
			marks = {
				Cursor = { text = " " },
				Search = { color = theme.yellow },
				Error = { color = theme.red },
				Warn = { color = theme.yellow },
				Info = { color = theme.green },
				Hint = { color = theme.blue },
				Misc = { color = theme.cyan },
			},
			handlers = {
				search = true,
			},
		})
		-- require("scrollbar.handlers.gitsigns").setup()
		require("scrollbar.handlers.search").setup({})
	end,
}
