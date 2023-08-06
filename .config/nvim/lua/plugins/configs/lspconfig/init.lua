local function config()
	local signs = { Error = "", Warn = " ", Hint = "", Info = "" }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	vim.diagnostic.config({
		virtual_text = false,
		signs = true,
		underline = true,
		update_in_insert = true,
		float = { source = "if_many" },
	})

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics,
		{ underline = true, update_in_insert = false, virtual_text = false, severity_sort = true }
	)

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
			{
				"ray-x/lsp_signature.nvim",
				event = { "InsertEnter" },
				config = function()
					require("lsp_signature").setup({
						bind = true,
						handler_opts = {
							border = "rounded",
						},
            hint_prefix = "",
					})
				end,
			},
		},
		config = config,
	},
}
