local function config()
	-- To apply the default configurations for the server doesn't configure by lspconfig
	-- e.g. formatter, linter, etc.
	vim.diagnostic.config({
		underline = true,
		float = {
			source = "if_many",
			format = function(diagnostic)
				if diagnostic.code then
					return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
				else
					return string.format("%s (%ss)", diagnostic.message, diagnostic.source)
				end
			end,
			header = {},
		},
		severity_sort = true,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "",
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.HINT] = "",
				[vim.diagnostic.severity.INFO] = "",
			},
		},
		virtual_text = false,
		-- virtual_lines = {
		--   current_line = true,
		-- },
		update_in_insert = true,
	})

	require("mason-lspconfig").setup_handlers({
		function(server_name)
			local conf = require("plugins.configs.lspconfig.server_config")[server_name]
			require("lspconfig")[server_name].setup(conf)
		end,
	})
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
