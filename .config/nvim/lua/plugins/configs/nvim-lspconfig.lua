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

	vim.lsp.config("*", {
		on_attach = function(_, bufnr)
			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
			-- NOTE: To use fuzzy finder instead of quickfix list
			-- other keymaps like GoToImplementation, GoToReferences are set in telescope.nvim config
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP: [G]oto [D]efinition" })
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP: [G]oto [D]eclaration" })
		end,
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
	})
end

return {
	{
		"neovim/nvim-lspconfig",
		ft = { "*" },
		dependencies = {
			-- make sure to setup neodev BEFORE lspconfig
			{ "folke/neodev.nvim", lazy = true },
			{ "hrsh7th/cmp-nvim-lsp", ft = { "*" } },
			{ "mason-org/mason-lspconfig.nvim" },
		},
		config = config,
	},
}
