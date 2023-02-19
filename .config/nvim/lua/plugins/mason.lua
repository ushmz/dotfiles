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
		automatic_installation = true,
		ensure_installed = {
			-- LSP
			"bashls",
			"cssls",
			"dockerls",
			"eslint",
			"gopls",
			"html",
			"jsonls",
			"kotlin_language_server",
			"lua_ls",
			"prismals",
			"pyright",
			"rust_analyzer",
			"solargraph",
			"sqlls",
			"stylelint_lsp",
			"tailwindcss",
			"tsserver",
			"yamlls",
		},
	})
	-- Following tools cannot install via `ensure_installed` option,
	-- make sure to install them manually ;)
	-- FYI: 'WhoIsSethDaniel/mason-tool-installer.nvim'
	-- 'flake8',
	-- 'ktlint',
	-- 'markdownlint',
	-- 'rubocop',
	-- 'black',
	-- 'goimports',
	-- 'prettier',
	-- 'shfmt',
	-- 'yamlfmt',
	--
	-- Install like this.
	-- vim.cmd[[
	--   MasonInstall flake8 ktlint markdownlint rubocop black goimports prettier shfmt yamlfmt
	-- ]]
end

return {
	{
		"williamboman/mason.nvim",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = mason,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = mason_lspconfig,
	},
}
