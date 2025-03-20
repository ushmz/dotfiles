return {
	"kevinhwang91/nvim-bqf",
	event = { "VeryLazy" },
	config = function()
		require("bqf").setup({
			auto_enable = true,
			func_map = {
				vsplit = "",
			},
		})
	end,
}
