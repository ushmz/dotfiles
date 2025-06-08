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
			vim.keymap.set("n", "==", function()
				vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 5000 })
			end, { buffer = bufnr, desc = "LSP: Document formatting" })

			local fmtag = vim.api.nvim_create_augroup("LspDocumentFormatting", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				group = fmtag,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 5000 })
				end,
			})
		end,
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
	})

	-- FIXME: Workaround for switching biome and eslint
	if vim.fs.root(0, { "biome.json", "biome.jsonc" }) then
    vim.lsp.enable("biome")
  else
    vim.lsp.enable("eslint")
  end
end

return {
	{
		"neovim/nvim-lspconfig",
		ft = { "*" },
		dependencies = {
			{ "folke/lazydev.nvim", ft = { "lua" } },
			{ "hrsh7th/cmp-nvim-lsp", ft = { "*" } },
			{ "mason-org/mason-lspconfig.nvim" },
		},
		config = config,
	},
}
