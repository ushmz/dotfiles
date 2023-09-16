return {
	"levouh/tint.nvim",
	event = { "BufRead" },
	config = function()
		require("tint").setup({})
	end,
}
