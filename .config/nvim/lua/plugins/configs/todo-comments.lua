return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = { "TodoTrouble", "TodoQuickFix", "TodoTelescope" },
	event = { "BufNewFile", "BufRead" },
	config = function()
		local colors = require("kanagawa.colors").setup({ theme = "dragon" })
		require("todo-comments").setup({
			keywords = {
				FIX = { icon = " ", color = colors.palette.dragonRed, alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
				TODO = { icon = " ", color = colors.palette.dragonGreen2, alt = { "TODO" } },
				HACK = { icon = " ", color = colors.palette.dragonYellow, alt = { "HELPME" } },
				WARN = { icon = " ", color = colors.palette.dragonYellow, alt = { "WARNING" } },
				NOTE = { icon = "󰏫", color = colors.palette.dragonBlue, alt = { "INFO" } },
				TEST = { icon = " ", color = colors.palette.dragonViolet, alt = { "TESTING", "PASSED", "FAILED" } },
				QUESTION = { icon = "", color = colors.palette.dragonTeal, alt = { "QUESTION" } },
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
