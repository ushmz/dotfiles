return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		branch = "main",
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site"),
			})
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
		event = { "BufEnter" },
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
		event = { "BufEnter" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
		end,
	},
}
