return {
	"folke/neodev.nvim",
	ft = { "lua" },
	config = function()
		require("neodev").setup({
			library = {
				enabled = true,
				runtime = true,
				types = true,
				plugins = { "nvim-dap-ui", "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
			},
			setup_jsonls = true,
			override = function(root_dir, options) end,
			lspconfig = true,
			pathStrict = true,
		})
	end,
}
