return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = { "TodoTrouble", "TodoQuickFix", "TodoTelescope" },
	event = { "BufNewFile", "BufRead" },
	config = function()
		local colors = require("theme").colors
		require("todo-comments").setup({
			keywords = {
				FIX = { icon = " ", color = colors.dim.red, alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
				TODO = { icon = " ", color = colors.dim.green, alt = { "TODO" } },
				HACK = { icon = " ", color = colors.dim.yellow, alt = { "HELPME" } },
				WARN = { icon = " ", color = colors.dim.yellow, alt = { "WARNING" } },
				NOTE = { icon = "󰏫", color = colors.dim.blue, alt = { "INFO" } },
				TEST = { icon = " ", color = colors.dim.purple, alt = { "TESTING", "PASSED", "FAILED" } },
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
