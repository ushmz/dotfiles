return {
	"numToStr/Comment.nvim",
	event = { "BufNewFile", "BufRead" },
	config = function()
		require("Comment").setup({
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})
	end,
	dependencies = {
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			event = { "BufNewFile", "BufRead" },
			dependencies = { "nvim-treesitter/nvim-treesitter" },
			config = function()
				require("ts_context_commentstring").setup({
					enable_autocmd = false,
				})
			end,
		},
	},
}
