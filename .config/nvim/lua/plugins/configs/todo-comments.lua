return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufRead" },
	config = function()
		local theme = require("plugins.utils").theme
		require("todo-comments").setup({
			keywords = {
				FIX = { icon = " ", color = theme.dim.red, alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
				TODO = { icon = " ", color = theme.dim.green, alt = { "[TODO]" } },
				HACK = { icon = " ", color = theme.dim.yellow },
				WARN = { icon = " ", color = theme.dim.yellow, alt = { "WARNING" } },
				NOTE = { icon = "󰏫", color = theme.dim.blue, alt = { "INFO" } },
				TEST = { icon = " ", color = theme.dim.purple, alt = { "TESTING", "PASSED", "FAILED" } },
			},
			gui_style = {
				fg = "BOLD",
			},
			highlight = {
				before = "",
				keyword = "fg",
				after = "",
				pattern = { [[.*<(KEYWORDS)\s*:]], [[.*\[<(KEYWORDS)\]\s*:*]] },
			},
		})
	end,
}
