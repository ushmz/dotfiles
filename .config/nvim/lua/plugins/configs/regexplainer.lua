local config = function()
	require("regexplainer").setup({
		auto = false,
		debug = false,
		display = "popup",
		filetypes = {
			"js",
			"ts",
			"jsx",
			"tsx",
		},
		mappings = {
			toggle = "gR",
			show_split = 'gP',
			show_popup = 'gU',
		},
		narrative = {
			separator = "\n",
		},
	})
end
return {
	"bennypowers/nvim-regexplainer",
	event = { "BufRead" },
	ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	config = config,
	requires = {
		"nvim-treesitter/nvim-treesitter",
		"MunifTanjim/nui.nvim",
	},
}
