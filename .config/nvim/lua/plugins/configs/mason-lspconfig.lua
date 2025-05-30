return {
	"mason-org/mason-lspconfig.nvim",
	lazy = true,
	dependencies = {
		{ "mason-org/mason.nvim" },
	},
	config = function()
		local servers = {
			-- cSpell:disable
			"bashls",
			"cssls",
			"dockerls",
			"eslint",
			"gopls",
			"html",
			"jsonls",
			"kotlin_language_server",
			"lua_ls",
			"pyright",
			-- "ruff_lsp",
			"rust_analyzer",
			"sqlls",
			"stylelint_lsp",
			"tailwindcss",
			"ts_ls",
			-- cSpell:enable
		}

		require("mason-lspconfig").setup({
			automatic_enable = true,
			ensure_installed = servers,
		})
		-- Manually install like this
		-- FYI: 'WhoIsSethDaniel/mason-tool-installer.nvim'
		-- vim.cmd([[
		--   MasonInstall cspell dockerfile-language-server goimports html-lsp markdownlint
		--    \ prettier rubocop rustfmt shfmt solargraph stylua
		--    \ yaml-language-server yamlfmt yamllint
		--   ]])
		--
		-- You should also install the dictionaries for cspell
		-- vim.cmd([[
		--  !npm install -g ...
		-- ]])
	end,
}
