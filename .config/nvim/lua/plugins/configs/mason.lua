local function mason()
	require("mason").setup({
		ui = {
			border = "rounded",
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})
end

local function mason_lspconfig()
	require("mason-lspconfig").setup({
		-- cSpell:disable
		ensure_installed = {
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
		},
		-- cSpell:enable
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
end

return {
	{
		"williamboman/mason-lspconfig.nvim",
		cmd = "Mason",
		dependencies = {
			{ "williamboman/mason.nvim", config = mason },
		},
		config = mason_lspconfig,
	},
}
