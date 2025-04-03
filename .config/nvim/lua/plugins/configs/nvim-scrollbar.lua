return {
	"petertriho/nvim-scrollbar",
	event = { "BufNewFile", "BufRead" },
	dependencies = {
		{ "lewis6991/gitsigns.nvim" },
		{ "kevinhwang91/nvim-hlslens" },
	},
	config = function()
		local colors = require("kanagawa.colors").setup({ theme = "dragon" })
		require("scrollbar").setup({
			max_lines = 2000,
			handle = {
				highlight = "CursorLine",
				hide_if_all_visible = true,
			},
			marks = {
				Cursor = { text = " " },
				Search = { color = colors.palette.dragonYellow },
				Error = { color = colors.palette.dragonRed },
				Warn = { color = colors.palette.dragonYellow },
				Info = { color = colors.palette.dragonGreen2 },
				Hint = { color = colors.palette.dragonBlue },
				Misc = { color = colors.palette.dragonTeal },
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
