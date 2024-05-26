return {
	"petertriho/nvim-scrollbar",
	event = { "BufNewFile", "BufRead" },
	dependencies = {
		{ "lewis6991/gitsigns.nvim" },
		{ "kevinhwang91/nvim-hlslens" },
	},
	config = function()
		local colors = require("theme").colors
		require("scrollbar").setup({
			max_lines = 2000,
			handle = {
				highlight = "CursorLine",
				hide_if_all_visible = true,
			},
			marks = {
				Cursor = { text = " " },
				Search = { color = colors.yellow },
				Error = { color = colors.red },
				Warn = { color = colors.yellow },
				Info = { color = colors.green },
				Hint = { color = colors.blue },
				Misc = { color = colors.cyan },
			},
			excluded_buftypes = {
				"terminal",
				"popup",
				"nofile",
			},
			handlers = {
				search = true,
			},
		})
		-- require("scrollbar.handlers.gitsigns").setup()
		require("scrollbar.handlers.search").setup({})
	end,
}
