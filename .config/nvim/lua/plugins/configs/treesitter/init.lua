return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		branch = "main",
		config = function()
			vim.g.skip_ts_context_commentstring_module = true
		end,
	},
	{
		"RRethy/nvim-treesitter-endwise",
		event = { "InsertEnter" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-endwise").init()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = { "BufNewFile", "BufRead" },
		opts = {
			select = {
				lookahead = true,
			},
		},
		config = function()
			require("plugins.configs.treesitter.textobj.select").setup()
			require("plugins.configs.treesitter.textobj.swap").setup()
			require("plugins.configs.treesitter.textobj.move").setup()
			require("plugins.configs.treesitter.textobj.repeat").setup()
		end,
	},
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
}
