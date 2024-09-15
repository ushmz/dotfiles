local function config()
	-- To apply the default configurations for the server doesn't configure by lspconfig
	-- e.g. formatter, linter, etc.
	vim.diagnostic.config({
		underline = true,
		float = { source = "if_many" },
		severity_sort = true,
		signs = true,
		virtual_text = false,
		update_in_insert = true,
	})

	require("mason-lspconfig").setup_handlers({
		function(server_name)
			local conf = require("plugins.configs.lspconfig.server_config")[server_name]
			require("lspconfig")[server_name].setup(conf)
		end,
	})

	require("plugins.configs.lspconfig.hl").set()
end

return {
	{
		"neovim/nvim-lspconfig",
		event = { "InsertEnter" },
		dependencies = {
			-- make sure to setup neodev BEFORE lspconfig
			{ "folke/neodev.nvim", ft = { "lua" } },
			{ "hrsh7th/cmp-nvim-lsp", event = { "InsertEnter" } },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = config,
	},
}
