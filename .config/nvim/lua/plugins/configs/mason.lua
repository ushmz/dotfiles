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
			"rust_analyzer",
			"sqlls",
			"stylelint_lsp",
			"tailwindcss",
			"tsserver",
		},
	})

	-- Manually install like this
	-- FYI: 'WhoIsSethDaniel/mason-tool-installer.nvim'
	-- vim.cmd([[
	--   MasonInstall black dockerfile-language-server flake8 goimports html-lsp ktlint markdownlint
	--    \ prettier prisma-language-server rubocop rustfmt shfmt solargraph stylua
	--    \ yaml-language-server yamlfmt yamllint
	--   ]])
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
