return {
	"folke/neodev.nvim",
	ft = { "lua" },
	config = function()
		require("neodev").setup({
			library = {
				enabled = true,
				runtime = true,
				types = true,
				plugins = true,
				-- you can also specify the list of plugins to make available as a workspace library
				-- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
			},
			setup_jsonls = true,
			override = function(root_dir, options) end,
			lspconfig = true,
			pathStrict = true,
		})
	end,
}
