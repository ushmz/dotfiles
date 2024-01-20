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
			},
			setup_jsonls = true,
			override = function(_, options)
				options.enabled = true
				-- Use treesitter and plenary.nvim as a workspace library
				options.plugins = { "nvim-treesitter", "plenary.nvim" }
			end,
			lspconfig = true,
			pathStrict = true,
		})
	end,
}
