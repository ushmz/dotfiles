return {
	"levouh/tint.nvim",
	event = "BufReadPost",
	config = function()
		require("tint").setup({})
	end,
}
